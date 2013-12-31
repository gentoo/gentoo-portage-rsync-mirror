# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cyassl/cyassl-2.7.0.ebuild,v 1.7 2013/12/24 12:53:24 ago Exp $

EAPI="5"

inherit eutils

DESCRIPTION="Lightweight SSL/TLS library targeted at embedded and RTOS environments"
HOMEPAGE="http://www.yassl.com/yaSSL/Home.html"
SRC_URI="http://dev.gentoo.org/~blueness/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm hppa ~mips ppc ppc64 ~s390 x86"

#Add CRYPTO_OPTS=ecc when fixed
CACHE_SIZE="small big +huge"
CRYPTO_OPTS="+aes aes-gcm aes-ccm aes-ni +arc4 +asn blake2 camellia +coding +dh dsa +des3 ecc +hc128 md2 md4 +md5 nullcipher +psk leanpsk rabbit +ripemd +rsa +sha sha512"
CERT_OPTS="ocsp crl crl-monitor savesession savecert +sessioncerts +testcert"
DEBUG="debug +errorstrings +memory test"
IUSE="-dtls examples extra fortress ipv6 +httpd mcapi pwdbased sni sniffer static-libs threads +zlib cyassl-hardening ${CACHE_SIZE} ${CRYPTO_OPTS} ${CERT_OPTS} ${DEBUG}"

#You can only pick one cach size
#sha512 is broken on x86
#Testing freezes with dtls
REQUIRED_USE="^^ ( small big huge )
	leanpsk? ( psk )
	fortress? ( extra sha512 )
	pwdbased? ( extra )
	test? ( !dtls )"

DEPEND="app-arch/unzip
	sniffer? ( net-libs/libpcap )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.8-disable-testsuit-ifnothreads.patch
}

src_configure() {
	local myconf=()

	if use threads; then
		myconf+=( --disable-singlethreaded )
	else
		myconf+=( --enable-singlethreaded )
	fi

	if use amd64; then
		myconf+=( --enable-fastmath --enable-fasthugemath --enable-bump )
	elif use x86; then
		#not pie friendly, sorry x86, no fast math for you :(
		myconf+=( --disable-fastmath --disable-fasthugemath --disable-bump )
	fi

	#Bug #454300
	export C_EXTRA_FLAGS=${CFLAGS}

	econf \
		--disable-silent-rules              \
		--enable-keygen                     \
		--enable-certgen                    \
		--disable-stacksize                 \
		--disable-ntru                      \
		--enable-filesystem                 \
		--enable-inline                     \
		--disable-oldtls                    \
		--disable-valgrind                  \
		                                    \
		$(use_enable small smallcache)      \
		$(use_enable big bigcache)          \
		$(use_enable huge hugecache)        \
		                                    \
		$(use_enable aes)                   \
		$(use_enable aes-gcm aesgcm)        \
		$(use_enable aes-ccm aesccm)        \
		$(use_enable aes-ni aesni)          \
		$(use_enable arc4)                  \
		$(use_enable asn)                   \
		$(use_enable blake2)                \
		$(use_enable camellia)              \
		$(use_enable coding)                \
		$(use_enable dh)                    \
		$(use_enable dsa)                   \
		$(use_enable des3)                  \
		$(use_enable ecc)                   \
		$(use_enable hc128)                 \
		$(use_enable md2)                   \
		$(use_enable md4)                   \
		$(use_enable md5)                   \
		$(use_enable nullcipher)            \
		$(use_enable psk)                   \
		$(use_enable leanpsk)               \
		$(use_enable rabbit)                \
		$(use_enable ripemd)                \
		$(use_enable rsa)                   \
		$(use_enable sha)                   \
		$(use_enable sha512)                \
		                                    \
		$(use_enable ocsp)                  \
		$(use_enable crl)                   \
		$(use_enable crl-monitor)           \
		$(use_enable savesession)           \
		$(use_enable savecert)              \
		$(use_enable sessioncerts)          \
		$(use_enable testcert)              \
		                                    \
		$(use_enable debug)                 \
		$(use_enable errorstrings)          \
		$(use_enable memory)                \
		                                    \
		$(use_enable dtls)                  \
		$(use_enable examples)              \
		$(use_enable extra opensslextra)    \
		$(use_enable fortress)              \
		$(use_enable ipv6)                  \
		$(use_enable httpd webserver)       \
		$(use_enable mcapi)                 \
		$(use_enable pwdbased)              \
		$(use_enable sni)                   \
		$(use_enable sniffer)               \
		$(use_enable static-libs static)    \
		$(use_with zlib libz)               \
		$(use_enable cyassl-hardening gcc-hardening)    \
		"${myconf[@]}"
}

src_test() {
	"${S}"/tests/unit
	"${S}"/ctaocrypt/benchmark/benchmark
}

src_install() {
	default

	mv "${D}"/usr/share/doc/"${PN}"/* \
		"${D}"/usr/share/doc/"${P}"/
	rmdir "${D}"/usr/share/doc/"${PN}"/
}
