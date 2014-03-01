# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/criu/criu-1.2.ebuild,v 1.1 2014/03/01 05:40:30 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs linux-info flag-o-matic

DESCRIPTION="utility to checkpoint/restore a process tree"
HOMEPAGE="http://criu.org/"
SRC_URI="http://download.openvz.org/criu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/protobuf-c"
DEPEND="${RDEPEND}
	app-text/asciidoc
	app-text/xmlto"

CONFIG_CHECK="~CHECKPOINT_RESTORE ~NAMESPACES ~PID_NS ~FHANDLE ~EVENTFD ~EPOLL ~INOTIFY_USER
	~IA32_EMULATION ~UNIX_DIAG ~INET_DIAG ~INET_UDP_DIAG ~PACKET_DIAG ~NETLINK_DIAG"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.6-flags.patch
	epatch "${FILESDIR}"/${P}-makefile.patch

	# use raw ldflags for direct ld calls
	sed -i "s/\$\$\?(LDFLAGS)/$(raw-ldflags)/" scripts/Makefile.build || die
}

src_compile() {
	unset ARCH
	emake CC="$(tc-getCC)" LD="$(tc-getLD)" V=1 WERROR=0 all docs
}

src_test() {
	# root privileges are required to dump all necessary info
	if [[ ${EUID} -eq 0 ]] ; then
		emake -j1 CC="$(tc-getCC)" V=1 WERROR=0 test
	fi
}

src_install() {
	emake SYSCONFDIR="${EPREFIX}"/etc PREFIX="${EPREFIX}"/usr DESTDIR="${D}" install
	dodoc CREDITS README
}
