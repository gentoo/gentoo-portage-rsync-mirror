# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpdump/tcpdump-4.4.0-r1.ebuild,v 1.2 2013/06/02 14:50:22 jer Exp $

EAPI=5

AUTOTOOLS_AUTO_DEPEND="no" # Only cross-compiling
inherit eutils flag-o-matic user toolchain-funcs

DESCRIPTION="A Tool for network monitoring and data acquisition"
HOMEPAGE="http://www.tcpdump.org/"
SRC_URI="http://www.tcpdump.org/release/${P}.tar.gz
		http://www.jp.tcpdump.org/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~arm-linux ~x86-linux"
IUSE="+chroot smi ssl ipv6 -samba suid test"

RDEPEND="
	chroot? ( sys-libs/libcap-ng )
	net-libs/libpcap
	smi? ( net-libs/libsmi )
	ssl? ( >=dev-libs/openssl-0.9.6m )
"
DEPEND="
	${RDEPEND}
	chroot? ( virtual/pkgconfig )
	test? (
		|| ( app-arch/sharutils sys-freebsd/freebsd-ubin )
		dev-lang/perl
	)
"

pkg_setup() {
	if use samba ; then
		ewarn
		ewarn "CAUTION !!! CAUTION !!! CAUTION"
		ewarn
		ewarn "You're about to compile tcpdump with samba printing support"
		ewarn "Upstream tags it as 'possibly-buggy SMB printer'"
		ewarn "So think twice whether this is fine with you"
		ewarn
		ewarn "CAUTION !!! CAUTION !!! CAUTION"
		ewarn
	fi
	enewgroup tcpdump
	enewuser tcpdump -1 -1 -1 tcpdump
}

src_configure() {
	# tcpdump needs some optymalization. see bug #108391
	( ! is-flag -O? || is-flag -O0 ) && append-flags -O2
	if use chroot; then
		append-cppflags -DHAVE_CAP_NG_H
		export LIBS=$( $(tc-getPKG_CONFIG) --libs libcap-ng )
	fi

	replace-flags -O[3-9] -O2
	filter-flags -finline-functions

	econf \
		$(use_enable ipv6) \
		$(use_enable samba smb) \
		$(use_with chroot chroot '') \
		$(use_with smi) \
		$(use_with ssl crypto "${EPREFIX}/usr") \
		--with-user=tcpdump
}

src_test() {
	sed '/^\(espudp1\|eapon1\)/d;' -i tests/TESTLIST
	emake check
}

src_install() {
	dosbin tcpdump
	doman tcpdump.1
	dodoc *.awk
	dodoc CHANGES CREDITS README

	if use suid; then
		fowners root:tcpdump /usr/sbin/tcpdump
		fperms 4110 /usr/sbin/tcpdump
	fi
}

pkg_postinst() {
	use suid && elog "To let normal users run tcpdump add them into tcpdump group."
}
