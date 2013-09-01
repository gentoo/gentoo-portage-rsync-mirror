# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openswan/openswan-2.6.39.ebuild,v 1.3 2013/09/01 15:27:31 ago Exp $

EAPI="4"

inherit eutils linux-info toolchain-funcs flag-o-matic

DESCRIPTION="Open Source implementation of IPsec for the Linux operating system (was SuperFreeS/WAN)."
HOMEPAGE="http://www.openswan.org/"
SRC_URI="http://download.openswan.org/openswan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="caps curl ldap pam ssl extra-algorithms weak-algorithms nocrypto-algorithms ms-bad-proposal nss"

RESTRICT="test" # requires user mode linux setup

COMMON_DEPEND="!net-misc/strongswan
	dev-libs/gmp
	dev-lang/perl
	caps? ( sys-libs/libcap-ng )
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	nss? ( dev-libs/nss )
	ssl? ( dev-libs/openssl )"
DEPEND="${COMMON_DEPEND}
	virtual/linux-sources
	app-text/xmlto
	app-text/docbook-xml-dtd:4.1.2" # see bug 237132
RDEPEND="${COMMON_DEPEND}
	|| ( sys-apps/net-tools[old-output] <sys-apps/net-tools-1.60_p201111202031570500 )
	virtual/logger
	sys-apps/iproute2"

pkg_setup() {
	if use nocrypto-algorithms && ! use weak-algorithms; then
		ewarn "Enabling nocrypto-algorithms USE flag has no effect when"
		ewarn "weak-algorithms USE flag is disabled"
	fi

	linux-info_pkg_setup

	if kernel_is -ge 2 6; then
		einfo "This ebuild will set ${P} to use kernel native IPsec (KAME)."
		MYMAKE="programs"

	elif kernel_is 2 4; then
		if ! [[ -d "${KERNEL_DIR}/net/ipsec" ]]; then
			eerror "You need to have an IPsec enabled 2.4.x kernel."
			eerror "Ensure you have one running and make a symlink to it in /usr/src/linux"
			die
		fi

		einfo "Using patched-in IPsec code for kernel 2.4"
		einfo "Your kernel only supports KLIPS for kernel level IPsec."
		MYMAKE="confcheck programs"

	else
		die "Unsupported kernel version"
	fi

	# most code is OK, but programs/pluto code breaks strict aliasing
	append-cflags -fno-strict-aliasing
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	use ms-bad-proposal && epatch "${FILESDIR}"/${PN}-${PV%.*}-allow-ms-bad-proposal.patch

	find . -type f -regex '.*[.]\([1-8]\|html\|xml\)' -exec sed -i \
	    -e s:/usr/local:/usr:g '{}' \; ||
	    die "failed to replace text in docs"
}

usetf() { usex $1 true false ; }
get_make_options() {
	make_options=(
		KERNELSRC="${KERNEL_DIR}"
		FINALEXAMPLECONFDIR=/usr/share/doc/${PF}
		INC_RCDEFAULT=/etc/init.d
		INC_USRLOCAL=/usr
		INC_MANDIR=share/man
		FINALDOCDIR=/usr/share/doc/${PF}/html
		FINALLIBDIR=/usr/$(get_libdir)/ipsec
		DESTDIR="${D}"
		USERCOMPILE="${CFLAGS}"
		USERLINK="-Wl,-z,relro ${LDFLAGS}"
		CC="$(tc-getCC)"
		USE_LIBCAP_NG=$(usetf caps)
		USE_LIBCURL=$(usetf curl)
		USE_LDAP=$(usetf ldap)
		USE_XAUTH=true
		USE_XAUTHPAM=$(usetf pam)
		USE_LIBNSS=$(usetf nss)
		HAVE_OPENSSL=$(usetf ssl)
		USE_EXTRACRYPTO=$(usetf extra-algorithms)
		USE_WEAKSTUFF=$(usetf weak-algorithms)
	)

	if use weak-algorithms && use nocrypto-algorithms ; then
		make_options+=( USE_NOCRYPTO=true )
	fi

	make_options+=( USE_LWRES=false ) # needs bind9 with lwres support
	if use curl || use ldap || use pam; then
		make_options+=( HAVE_THREADS=true )
	else
		make_options+=( HAVE_THREADS=false )
	fi
}

src_compile() {
	local make_options; get_make_options
	emake "${make_options[@]}" ${MYMAKE}
}

src_install() {
	local make_options; get_make_options
	emake "${make_options[@]}" install

	dodoc CHANGES README
	dodoc docs/{KNOWN_BUGS*,RELEASE-NOTES*,PATENTS*,debugging*}
	docinto quickstarts
	dodoc docs/quickstarts/*

	insinto /usr/share/doc/${PF}
	doins -r contrib
	docompress -x /usr/share/doc/${PF}/contrib

	newinitd "${FILESDIR}"/ipsec-initd ipsec

	# We don't need to install /var/run/pluto.
	rm -rf "${D}var" || die
}

pkg_preinst() {
	if has_version "<net-misc/openswan-2.6.14" && pushd "${ROOT}etc/ipsec"; then
		ewarn "Following files and directories were moved from '${ROOT}etc/ipsec' to '${ROOT}etc':"
		local i err=0
		if [ -h "../ipsec.d" ]; then
			rm "../ipsec.d" || die "failed to remove ../ipsec.d symlink"
		fi
		for i in *; do
			if [ -e "../$i" ]; then
				eerror "  $i NOT MOVED, ../$i already exists!"
				err=1
			elif [ -d "$i" ]; then
				mv "$i" .. || die "failed to move $i directory"
				ewarn "  directory $i"
			elif [ -f "$i" ]; then
				sed -i -e 's:/etc/ipsec/:/etc/:g' "$i" && \
					mv "$i" .. && ewarn "  file $i" || \
					die "failed to move $i file"
			else
				eerror "  $i NOT MOVED, it is not a file nor a directory!"
				err=1
			fi
		done
		popd
		if [ $err -eq 0 ]; then
			rmdir "${ROOT}etc/ipsec" || eerror "Failed to remove ${ROOT}etc/ipsec"
		else
			ewarn "${ROOT}etc/ipsec is not empty, you will have to remove it yourself"
		fi
	fi
}

pkg_postinst() {
	if kernel_is -ge 2 6; then
		CONFIG_CHECK="~NET_KEY ~INET_XFRM_MODE_TRANSPORT ~INET_XFRM_MODE_TUNNEL ~INET_AH ~INET_ESP ~INET_IPCOMP"
		WARNING_INET_AH="CONFIG_INET_AH:\tmissing IPsec AH support (needed if you want only authentication)"
		WARNING_INET_ESP="CONFIG_INET_ESP:\tmissing IPsec ESP support (needed if you want authentication and encryption)"
		WARNING_INET_IPCOMP="CONFIG_INET_IPCOMP:\tmissing IPsec Payload Compression (required for compress=yes)"
		check_extra_config
	fi
}
