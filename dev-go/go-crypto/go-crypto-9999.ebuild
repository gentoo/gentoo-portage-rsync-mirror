# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-go/go-crypto/go-crypto-9999.ebuild,v 1.3 2015/05/21 08:45:02 zmedico Exp $

EAPI=5
inherit git-r3

KEYWORDS=""
DESCRIPTION="Go supplementary cryptography libraries"
GO_PN=golang.org/x/${PN##*-}
HOMEPAGE="https://godoc.org/${GO_PN}"
EGIT_REPO_URI="https://go.googlesource.com/${PN##*-}"
LICENSE="BSD"
SLOT="0"
IUSE=""
DEPEND=">=dev-lang/go-1.4"
RDEPEND=""
S="${WORKDIR}/src/${GO_PN}"
EGIT_CHECKOUT_DIR="${S}"
STRIP_MASK="*.a"

src_compile() {
	# Create a writable GOROOT in order to avoid sandbox violations.
	GOROOT="${WORKDIR}/goroot"
	cp -sR "${EPREFIX}"/usr/lib/go "${GOROOT}" || die
	rm -rf "${GOROOT}/src/${GO_PN%/*}" \
		"${GOROOT}/pkg/linux_${ARCH}/${GO_PN%/*}" || die
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} go install -v -x -work ${GO_PN}/... || die
}

src_test() {
	GOROOT="${GOROOT}" GOPATH=${WORKDIR} \
		go test -run "^"$(
		echo -n 'Example_usage|Test(AcceptClose|AgainstLibOTR|Agent|'
		echo -n 'Append|Append|AppendNoRealloc|Auth|Auth|'
		echo -n 'AuthMethodFallback|AuthMethodInvalidPublicKey|'
		echo -n 'AuthMethodKeyboardInteractive|AuthMethodPassword|'
		echo -n 'AuthMethodRSAandDSA|AuthMethodWrongKeyboardInteractive|'
		echo -n 'AuthMethodWrongPassword|AuthorizedKeyBasic|'
		echo -n 'AuthWithInvalidSpace|AuthWithMissingQuote|'
		echo -n 'AuthWithQuotedCommaInEnv|AuthWithQuotedQuoteInEnv|'
		echo -n 'AuthWithQuotedSpaceInEnv|AutoPortListenBroken|BadSMP|'
		echo -n 'BareMarshal|BareMarshalUnmarshal|BaseScalarMult|'
		echo -n 'Basic|BcryptingIsCorrect|BcryptingIsEasy|Bilinearity|'
		echo -n 'Blocksize|Box|BufferClose|BufferReadwrite|CampbellQuine|'
		echo -n 'CanonicalText|Cert|CertLogin|Cipher|CipherDecrypt|'
		echo -n 'CipherDecrypt|CipherEncrypt|CipherEncrypt|CipherInit|'
		echo -n 'Ciphers|ClientAuthPublicKey|ClientHandlesKeepalives|'
		echo -n 'ClientHMAC|ClientLoginCert|ClientUnsupportedCipher|'
		echo -n 'ClientUnsupportedKex|ClientWriteEOF|Close|Compressed|'
		echo -n 'Conversation|Core208|Cost|CostReturnsWithLeadingZeroes|'
		echo -n 'CostValidationInHash|CurveImpl|CustomClientVersion|'
		echo -n 'Debug|DecodeEncode|DecryptingEncryptedKey|'
		echo -n 'DefaultCiphersExist|DefaultClientVersion|'
		echo -n 'DetachedSignature|DetachedSignatureDSA|Dial|'
		echo -n 'DoubleClose|DSAHashTruncatation|Ecc384Serialize|'
		echo -n 'EncodeDecode|EncryptDecrypt|EncryptingEncryptedKey|'
		echo -n 'Encryption|ExchangeVersions|ExchangeVersionsBasic|'
		echo -n 'ExitSignalAndStatus|ExitStatusNonZero|ExitStatusZero|'
		echo -n 'ExitWithoutStatusOrSignal|ExternallyRevocableKey|Full|'
		echo -n 'G1Identity|G1Marshal|G2Identity|G2Marshal|GetKeyById|'
		echo -n 'GFp12Invert|GFp2Invert|GFp6Invert|Golden|GoodSMP|'
		echo -n 'HandshakeAutoRekeyRead|HandshakeAutoRekeyWrite|'
		echo -n 'HandshakeBasic|HandshakeError|HandshakeTwice|HKDF|'
		echo -n 'HKDFLimit|HKDFMultiRead|HostKeyCert|HostKeyCheck|'
		echo -n 'IdVerification|IntLength|InvalidEntry|'
		echo -n 'InvalidHashErrors|InvalidKeySize|'
		echo -n 'InvalidServerConfiguration|InvalidTerminalMode|'
		echo -n 'IsQuery|Iterated|KeccakKats|Kexes|Key|KeyExpiry|'
		echo -n 'KeyMarshalParse|KeyPresses|KeyRevocation|'
		echo -n 'KeySerialization|KeySignVerify|KeyUsage|'
		echo -n 'KnownExitSignalOnly|Limited|LockClient|LockServer|'
		echo -n 'LongHeader|MACs|MarshalParsePublicKey|MarshalPtr|'
		echo -n 'MarshalUnmarshal|MillionA|MinorNotRequired|'
		echo -n 'MissingHashFunction|MuxChannelCloseWriteUnblock|'
		echo -n 'MuxChannelExtendedThreadSafety|MuxChannelOverflow|'
		echo -n 'MuxChannelRequest|MuxChannelRequestUnblock|'
		echo -n 'MuxCloseChannel|MuxCloseWriteChannel|'
		echo -n 'MuxConnectionCloseWriteUnblock|MuxDisconnect|'
		echo -n 'MuxGlobalRequest|MuxGlobalRequestUnblock|'
		echo -n 'MuxInvalidRecord|MuxMaxPacketSize|MuxReadWrite|'
		echo -n 'MuxReject|NewEntity|NewPublicKey|NewUserId|'
		echo -n 'NewUserIdWithInvalidInput|NoArmoredData|'
		echo -n 'NoPermissionsPassing|OCFB|OCSPDecode|'
		echo -n 'OCSPDecodeWithoutCert|OCSPRequest|'
		echo -n 'OCSPResponse|OCSPSignature|OpaqueParseReason|OrderG1|'
		echo -n 'OrderG2|OrderGT|PacketCiphers|Parse|Parse|ParseCert|'
		echo -n 'ParseCertWithOptions|ParseDSA|ParseECPrivateKey|'
		echo -n 'ParseLibOTRPrivateKey|ParseRSAPrivateKey|'
		echo -n 'ParseUserAttribute|ParseUserId|ParseWithNoNewlineAtEnd|'
		echo -n 'PartialLengthReader|PartialLengths|PasswordNotSaved|'
		echo -n 'PermissionsPassing|PortForward|'
		echo -n 'PortForwardConnectionClose|PrivateKeyRead|'
		echo -n 'PublicKeyRead|PublicKeySerialize|PublicKeyV3Read|'
		echo -n 'PublicKeyV3Serialize|ReadDSAKey|ReadFull|ReadHeader|'
		echo -n 'ReadingArmoredPrivateKey|ReadingArmoredPublicKey|'
		echo -n 'ReadKeyRing|ReadLength|ReadPrivateKeyRing|ReadVersion|'
		echo -n 'ReadVersionError|RereadKeyRing|RunCommandFailed|Salsa20|'
		echo -n 'Salted|SaltedCipher|SaltedCipherKeyLength|Sbox|SealOpen|'
		echo -n 'SealOpen|SecretBox|Serialize|Serialize|SerializeHeader|'
		echo -n 'SerializeSymmetricKeyEncrypted|Server|ServerWindow|'
		echo -n 'SessionCombinedOutput|SessionID|SessionOutput|'
		echo -n 'SessionShell|SessionStdoutPipe|SetupForwardAgent|'
		echo -n 'SignatureRead|SignatureReserialize|SignatureV3Read|'
		echo -n 'SignatureV3Reserialize|SignDetached|SignDetachedDSA|'
		echo -n 'SignedEncryptedMessage|SignedMessage|Signing|'
		echo -n 'SignTextDetached|SignVerify|Squeezing|SubkeyRevocation|'
		echo -n 'Sum|SymmetricallyEncrypted|SymmetricEncryption|'
		echo -n 'SymmetricKeyEncrypted|TerminalSetSize|TextSignedMessage|'
		echo -n 'TooLongPasswordsWork|TransportMaxPacketReader|'
		echo -n 'TransportMaxPacketWrite|TripartiteDiffieHellman|'
		echo -n 'UnknownExitSignal|UnknownHashFunction|UnmarshalEmptyPacket|'
		echo -n 'UnmarshalUnexpectedPacket|UnpaddedBase64Encoding|'
		echo -n 'UnspecifiedRecipient|UnsupportedCurves|ValidateCert|'
		echo -n 'ValidateCertTime|Vectors|VeryShortPasswords|WithHMACSHA1|'
		echo -n 'WithHMACSHA256|XSalsa20|XTS|ZeroWindowAdjust)$') \
		-x -v ${GO_PN}/... || die $?
}

src_install() {
	insinto /usr/lib/go
	find "${WORKDIR}"/{pkg,src} -name '.git*' -exec rm -rf {} \; 2>/dev/null
	doins -r "${WORKDIR}"/{pkg,src}
}
