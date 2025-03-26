using System;
using System.Security.Cryptography;
using System.Text;

namespace ScoreManagement.Services
{
    public class RSAEncryption
    {
        private static readonly string _publicKey = @"
                                                   -----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgH1WPfWCru8g7mqQFpBHT3zAKfar
KLkX9uUVf4qTQ0b75YBNC4qsm75BXf8mo0lfAYK+DdkTt6XZlx2blzPmi18WqWMw
x8s5/T49+Vn2Zcu+7CZUg1l0GuiI+Ma5E/Biqt+nQGUiUKeqJfmcLfLpvBdIplPA
3bSsjAM+UvI4tDTtAgMBAAE=
-----END PUBLIC KEY-----";

        private static readonly string _privateKey = @"
                                                   -----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgH1WPfWCru8g7mqQFpBHT3zAKfarKLkX9uUVf4qTQ0b75YBNC4qs
m75BXf8mo0lfAYK+DdkTt6XZlx2blzPmi18WqWMwx8s5/T49+Vn2Zcu+7CZUg1l0
GuiI+Ma5E/Biqt+nQGUiUKeqJfmcLfLpvBdIplPA3bSsjAM+UvI4tDTtAgMBAAEC
gYAIiQn5ISgmkriJuzw+IQ0RsshoyukgCbi/iwI/fp3TRK4xWY3SqMSGZU8wZAI0
qeqha63nvYcBHVtEIedfGnEdNPCdLlaaO0RS0itN5r6C2DqHmR6JQiF8W/AW70C6
Eq5iTq+Um1OxBI2NPLK5YHEAdEcwsByLChep4JJrHjCPhQJBANCazTPmHgMRu/Lb
NrCcU5+RS6AWL1Q5hUCF1MkjzboX/8gEgxihiLOT15AzKPczlrWr6I1QZFED1a92
yAYOfzcCQQCZ0EkR8f3e9FZiZh8Gb/P6kLnMzARmgYKiiWFefb1kzgOL1pFHjxgQ
3dxllDlU/+Ae5qGehCCnjTo4oVSqx1b7AkEAwqtjygX6hfS7x6QpAmGwbB2kTG3H
lzrijlcWPuqJpxuUWC1Vxdug/ax/IxOLLD3ZbApUR+P46d3BQTCA8539uwJAMuka
BnKOkQlWvmMGyd6sZrcYiIzOuA8N6jaGn/wGgCMgUVzH4WOfl5WXqZeSEmxPBmtX
+1vIYyz/pFbh61TnmQJBAKgMo0GQnAVY5PkItWoGd1YL9cAZv2k+xIRFCGAmzKHb
l+RVpq3VoJ7AxaFF0TfIfiPDu5zgbAaMpaKjhDiNM84=
-----END RSA PRIVATE KEY-----
";

        public static string Encrypt(string text)
        {
            using (RSA rsa = RSA.Create())
            {
                rsa.ImportFromPem(_publicKey);
                byte[] data = Encoding.UTF8.GetBytes(text);
                byte[] encryptedData = rsa.Encrypt(data, RSAEncryptionPadding.OaepSHA256);
                return Convert.ToBase64String(encryptedData);
            }
        }

        public static string Decrypt(string encryptedText)
        {
            using (RSA rsa = RSA.Create())
            {
                rsa.ImportFromPem(_privateKey);
                byte[] encryptedData = Convert.FromBase64String(encryptedText);
                byte[] decryptedData = rsa.Decrypt(encryptedData, RSAEncryptionPadding.OaepSHA256);
                return Encoding.UTF8.GetString(decryptedData);
            }
        }
    }
}
