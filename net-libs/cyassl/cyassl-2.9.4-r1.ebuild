# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cyassl/cyassl-2.9.4-r1.ebuild,v 1.1 2014/06/09 20:45:54 blueness Exp $

EAPI="5"

inherit autotools eutils

DESCRIPTION="Lightweight SSL/TLS library targeted at embedded and RTOS environments"
HOMEPAGE="http://www.yassl.com/yaSSL/Home.html"
SRC_URI="http://dev.gentoo.org/~blueness/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~s390 ~x86"

CACHE_SIZE="small big huge"
CRYPTO_OPTS="aes-gcm aes-ccm aes-ni blake2 camellia dsa ecc hc128 hkdf md2 md4 nullcipher psk leanpsk pkcs7 rabbit ripemd scep sha512 supportedcurves"
CERT_OPTS="ocsp crl crl-monitor savesession savecert sessioncerts testcert"
EXTRAS="atomicuser pkcallbacks sep maxfragment truncatedhmac tlsx"
DEBUG="debug errorstrings memory test"

#Note: sniffer is broken at the configure.ac level.  Its not too important and we'll disable it for this release.
#IUSE="-dtls examples extra fortress ipv6 httpd mcapi pwdbased sni sniffer static-libs threads zlib ${CACHE_SIZE} ${CRYPTO_OPTS} ${CERT_OPTS} ${EXTRAS} ${DEBUG}"
IUSE="-dtls examples extra fortress ipv6 httpd mcapi pwdbased sni static-libs threads zlib ${CACHE_SIZE} ${CRYPTO_OPTS} ${CERT_OPTS} ${EXTRAS} ${DEBUG}"

#You can only pick one cach size
#sha512 is broken on x86
#Testing freezes with dtls
REQUIRED_USE="
	leanpsk? ( psk )
	fortress? ( extra sha512 )
	pwdbased? ( extra )
	test? ( !dtls )"

# Re-add sniffer? ( net-libs/libpcap ) to DEPEND when its fixed
DEPEND="app-arch/unzip
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

# More trouble ahead, bug #512312
RESTRICT="test"

src_prepare() {
	# More trouble ahead, bug #512312
	#epatch "${FILESDIR}"/${PN}-2.0.8-disable-testsuit-ifnothreads.patch
	epatch "${FILESDIR}"/${PN}-2.9.4-remove-hardened-flags.patch
	eautoreconf
}

src_configure() {
	local myconf=()

	if use debug; then
		myconf+=( --enable-debug )
	fi

	if use x86; then
		#not pie friendly, sorry x86, no fast math for you :(
		myconf+=( --disable-keygen --disable-fastmath --disable-fasthugemath --disable-bump )
	else
		myconf+=( --enable-keygen --enable-fastmath --enable-fasthugemath --enable-bump )
	fi

	#Bug #454300
	export C_EXTRA_FLAGS=${CFLAGS}

	econf \
		$(usex threads --disable-singlethreaded --enable-singlethreaded) \
		                                    \
		--disable-silent-rules              \
		--enable-certgen                    \
		--disable-stacksize                 \
		--disable-ntru                      \
		--enable-filesystem                 \
		--enable-inline                     \
		--disable-oldtls                    \
		--disable-valgrind                  \
		--enable-asn                        \
		--enable-md5                        \
		--enable-arc4                       \
		--enable-des3                       \
		--enable-aes                        \
		--enable-sha                        \
		--enable-rsa                        \
		--enable-dh                         \
		--enable-coding                     \
		                                    \
		$(use_enable small smallcache)      \
		$(use_enable big bigcache)          \
		$(use_enable huge hugecache)        \
		                                    \
		$(use_enable aes-gcm aesgcm)        \
		$(use_enable aes-ccm aesccm)        \
		$(use_enable aes-ni aesni)          \
		$(use_enable blake2)                \
		$(use_enable camellia)              \
		$(use_enable dsa)                   \
		$(use_enable ecc)                   \
		$(use_enable hc128)                 \
		$(use_enable hkdf)                  \
		$(use_enable md2)                   \
		$(use_enable md4)                   \
		$(use_enable nullcipher)            \
		$(use_enable psk)                   \
		$(use_enable leanpsk)               \
		$(use_enable pkcs7)                 \
		$(use_enable rabbit)                \
		$(use_enable ripemd)                \
		$(use_enable scep)                  \
		$(use_enable sha512)                \
		$(use_enable supportedcurves)       \
		                                    \
		$(use_enable ocsp)                  \
		$(use_enable crl)                   \
		$(use_enable crl-monitor)           \
		$(use_enable savesession)           \
		$(use_enable savecert)              \
		$(use_enable sessioncerts)          \
		$(use_enable testcert)              \
		                                    \
		$(use_enable atomicuser)            \
		$(use_enable pkcallbacks)           \
		$(use_enable sep)                   \
		$(use_enable maxfragment)           \
		$(use_enable truncatedhmac)         \
		$(use_enable tlsx)                  \
                                            \
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
		$(use_enable static-libs static)    \
		$(use_with zlib libz)               \
		"${myconf[@]}"

# Re-add $(use_enable sniffer) when its fixed
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
