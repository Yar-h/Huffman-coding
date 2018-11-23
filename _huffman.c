#include <stdio.h>
#include <unistd.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

struct node {
  unsigned char character;
  int frequency;
  struct node *leftNode;
  struct node *rightNode;
};

struct node* create_node(unsigned char, int);
void add_leftNode(struct node*, struct node*);
void add_rightNode(struct node*, struct node*);
int compare_node_frequency(const void*, const void*);

void write_single_bit_to_file(int, FILE*);
int read_single_bit_from_file(FILE*);

int get_bit_from_char(unsigned char, int);
unsigned char change_bit_of_char(unsigned char, int, int);
unsigned char reverse_bits(unsigned char);

int read_file(unsigned char*, unsigned char**);
void fill_look_up_table(unsigned char**, unsigned char*, struct node*);
void save_encoded_data (unsigned char*, unsigned char*, int, unsigned char*, int, struct node*);
void decode_file_with_tree(FILE*, struct node*, unsigned char*, int);

int fill_frequency_table(unsigned char*, int, struct node**);
struct node* build_tree(struct node**, int);
void get_tree_structure(unsigned char*, int*, struct node*);
struct node* restore_structure(FILE*);

int bit_index = -1;
unsigned char bit_buffer;

int main(int argc, char **argv){
  char  *input_fn  = argv[2];
  char  *output_fn = argv[3];
  FILE  *input_fp  = NULL;

  if (argc != 4) {
    fprintf(stderr, "Wrong number of arguments.\n");
    return -1;
  }

  switch(argv[1]) {
    case "-e":
      struct node **frequency_table = malloc(256 * sizeof(struct node*));
      int char_cnt = 0;
      unsigned char *text = 0;
      int text_length = 0;
      unsigned char *treeStruct = malloc(3000 * sizeof(char));
      int treeStructure_length = 0;

      if (input_fp = fopen(input_fn, "r")){
        fclose(file);  
      } else {
        fprintf(stderr, "Failed to open the file.\n");
        return -1;
      }

      text_length = read_file(input_fn, &text);
      char_cnt = fill_frequency_table(text, text_length, frequency_table);
      struct node *root = build_tree(frequency_table, char_cnt);
      get_tree_structure(treeStruct, &treeStructure_length, root);
      save_encoded_data(output_fn, treeStruct, treeStructure_length, text, text_length, root);
      free(frequency_table);
      break;

    case "-d":
      if (input_fp = fopen(input_fn, "rb")) {
        int text_length;
        fread(&text_length, sizeof(int), 1, input_fp);
        unsigned char *text = malloc(text_length * sizeof(char));

        if (text_length != 0) {
          struct node *root = restore_structure(input_fp);
          decode_file_with_tree(input_fp, root, text, text_length);

          if (FILE *fp = fopen(output_fn, "wb")) {
            fwrite(text, sizeof(char), text_length, fp);
            fclose(fp);
          }      

          fclose(input_fp);
        } else {
          if (FILE *fp = fopen(output_fn, "wb")) fclose(fp);
        }
      } else {
        fprintf(stderr, "Failed to open the input file '%s'\n", input_fn);
      }
      break;

  }

  return 0;
}

int fill_frequency_table(unsigned char *text, int text_length, struct node **frequency_table){
  int symbols_in_table = 0;
  for (int i = 0; i < text_length; i++) {
    int k = 0;

    while ((k < symbols_in_table) && (frequency_table[k]!=NULL) && (frequency_table[k]->character != text[i])) k++;

    if (frequency_table[k] == NULL){
      frequency_table[k] = create_node(text[i], 1);
      symbols_in_table++;
    } else {
      frequency_table[k]->frequency++;
    }
  }

  return symbols_in_table;
}

struct node* build_tree(struct node **frequency_table, int symbols_in_table){
  struct node* parent = NULL;

  while (symbols_in_table > 1) {
    qsort(frequency_table, symbols_in_table, sizeof(struct node*), compare_node_frequency);

    int sum_frequency = frequency_table[symbols_in_table-1]->frequency + frequency_table[symbols_in_table-2]->frequency;
    parent = create_node((char)0, sum_frequency);
    parent->rightNode = frequency_table[symbols_in_table-1];
    parent->leftNode = frequency_table[symbols_in_table-2];

    frequency_table[symbols_in_table-1] = NULL;
    frequency_table[symbols_in_table-2] = parent;
    symbols_in_table--;
  }

  return frequency_table[0];
}


void get_tree_structure(unsigned char *result, int *len, struct node *root) {
  if (root == NULL) return;
  if (root->leftNode != NULL || root->rightNode != NULL) {
    *(result+*len) = '0';
    (*len)++;
    get_tree_structure(result, len, root->leftNode);
    get_tree_structure(result, len, root->rightNode);
    return;
  }

    *(result+*len) = '1';
    (*len)++;

    *(result+*len) = '_';
    (*len)++;

    *(result+*len) = root->character;
    (*len)++;

  return;
}

struct node* restore_structure(FILE *fp) {
  struct node *root = NULL;
  int bit = read_single_bit_from_file(fp);

  switch(bit){
    case 0:
      root = create_node((char)0, 0);
      root->leftNode = restore_structure(fp);
      root->rightNode = restore_structure(fp);
      break;
    case 1:
      root = create_node((char)0, 0);
      unsigned char character = (unsigned char)0;
      for (int index = 0; index < 8; index++)
        character = change_bit_of_char(character, index, read_single_bit_from_file(fp));
      root->character = reverse_bits(character);
      break;
  }

  return root;
}

void decode_file_with_tree(FILE *input_fp, struct node *root, unsigned char *text, int text_length) {
  struct node *node = root;
  int bit = 0;
  int tmp_text_length = 0;

  while (text_length != tmp_text_length) {
    bit = read_single_bit_from_file(input_fp);

    if (root->rightNode != NULL || root->leftNode != NULL) {
      node = switch(bit){
        case 0:
          node->rightNode;
        case 1: 
          node->leftNode;
      }
      if (node->rightNode  != NULL || node->lefttNode  != NULL) continue;
    }

    text[tmp_text_length++] = node->character;
    node = root;
  }
  return;
}

int read_file(unsigned char *input_fn, unsigned char **text){
  int text_length = 0;
  *text = NULL;

  if (FILE *fp = fopen(input_fn, "rb")) {
    fseek(fp, 0, SEEK_END);
    text_length = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    *text = malloc(text_length * sizeof(char));

    unsigned char symbol = (char)0;

    for (int p = 0; p < text_length; p++) {
      fread(&symbol, sizeof(char), 1, fp);
      *(*text+p) = symbol;
    }
    fclose(fp);
  }
  return text_length;
}

void fill_look_up_table(unsigned char** look_up, unsigned char* result, struct node* root) {
  if (root == NULL) return;
  if (root->rightNode == NULL)
    strcpy(look_up[(int)(root->character)], result);
  
  if (root->leftNode != NULL) {
    result[strlen(result)-1] = '1';
    fill_look_up_table(look_up, result, root->leftNode);
  }

  if (root->rightNode != NULL) {
    result[strlen(result)-1] = '0';
    fill_look_up_table(look_up, result, root->rightNode);
  }

  result[strlen(result)-1] = '\0';
  return;
}

void save_encoded_data (unsigned char *output_fn, unsigned char *treeStruct, int treeStructure_length, unsigned char *text, int text_length, struct node *root) {
  FILE *fp = NULL;
  unsigned char encoded_char[32];
  unsigned char** look_up;

  encoded_char[0] = '\0';

  if (fp = fopen(output_fn, "wb")){
    fwrite(&text_length, sizeof(int), 1, fp);
    
    for (int k = 0; k < treeStructure_length; k++) {
      switch(treeStruct[k]) { 
        case '0':
          write_single_bit_to_file(0, fp);
          break;
        case '1':
          write_single_bit_to_file(1, fp);
          break;
        default:
          for (int u = 0; u < 8; u++)
            write_single_bit_to_file(get_bit_from_char(treeStruct[k], u), fp);
      }
    }
    
    look_up = malloc(256*sizeof(unsigned char*));
    for (int i = 0; i < 256; i++){
      look_up[i] = malloc(32);
      look_up[i][0] = '\0';
    }
    fill_look_up_table(look_up, encoded_char, root);

    int ch_index = 0;
    for (int k = 0; k < text_length; k++ ){
      ch_index = (int)text[k];
      for (int j = 0; look_up[ch_index][j] != '\0'; j++ ) {
        if (look_up[ch_index][j] == '0') write_single_bit_to_file(0, fp);
        else if (look_up[ch_index][j] == '1') write_single_bit_to_file(1, fp);
      }
    }

    while (bit_index != 0)
      write_single_bit_to_file(0, fp);

    fclose(fp);
  }
}

void write_single_bit_to_file(int bit, FILE *fp) {
  if (fp == NULL) return;

  if (bit_index == -1)
    bit_index = 0;

  if (bit == 1)
    bit_buffer |= (1 << bit_index);

  bit_index++;

  if (bit_index == 8)
  {
    bit_buffer = reverse_bits(bit_buffer);
    fwrite(&bit_buffer, sizeof(char), 1, fp);
    bit_index = 0;
    bit_buffer = (unsigned char)0;
  }
  return;
}

int read_single_bit_from_file(FILE *fp) {
  if (bit_index < 0 || bit_index > 7) {
    bit_index = 0;
    fread(&bit_buffer, 1, 1, fp);
  }

  int b = 0;
  b = (c & (1 << (7 - index)))) ? 1 : 0;
  bit_index++;

  return b;
}

unsigned char change_bit_of_char(unsigned char c, int index, int value) {
  if ((value != 0) && (value != 1)) return c;
  unsigned long newbit = !!value;
  c ^= (-newbit ^ c) & (1UL << index);

  return c;
}

struct node* create_node(unsigned char character, int frequency) {
  struct node *newNode = malloc(sizeof(struct node));
  newNode->character = character;
  newNode->frequency = frequency;
  newNode->leftNode = NULL;
  newNode->rightNode = NULL;

  return newNode;
}

void add_leftNode(struct node *root, struct node *node){
  root->leftNode = node;
}

void add_rightNode(struct node *root, struct node *node){
  root->rightNode = node;
}

int compare_node_frequency(const void *a, const void *b){
  struct node *n1 = (struct node *)a;
  struct node *n2 = (struct node *)b;

  if ((int)n1->frequency == (int)n2->frequency) {
    return 0;
  } else if ((int)n1->frequency > (int)n2->frequency) {
    return -1;
  } else {
    return 1;
  }
}

unsigned char reverse_bits(unsigned char b){
  b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
  b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
  b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
  return b;
}