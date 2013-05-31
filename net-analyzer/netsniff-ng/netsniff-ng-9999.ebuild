# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netsniff-ng/netsniff-ng-9999.ebuild,v 1.1 2013/05/31 08:06:12 xmw Exp $

EAPI=5

inherit git-2 multilib toolchain-funcs

DESCRIPTION="high performance network sniffer for packet inspection"
HOMEPAGE="http://netsniff-ng.org/"
EGIT_REPO_URI="git://github.com/borkmann/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="curvetun mausezahn"

RDEPEND="dev-libs/geoip
	dev-libs/libnl:3
	dev-libs/userspace-rcu
	net-libs/libnetfilter_conntrack
	sys-libs/ncurses:5
	mausezahn? (
		dev-libs/libcli
		net-libs/libnet:1.1 )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	curvetun? (	=net-libs/nacl-0_p20110221* )"

src_prepare() {
	if ! use mausezahn ; then
		sed -e '/^TOOLS /s:mausezahn::' \
			-i Makefile
	fi
	if ! use curvetun ; then
		sed -e '/^TOOLS /s:curvetun::' \
			-i Makefile
	else
		if ! grep nacl-20110221 curvetun/nacl_build.sh >/dev/null ; then
			die "have nacl-20110221, expected $(grep ${MY_NACL_P} curvetun/nacl_build.sh)"
		fi
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" LD="$(tc-getCC)" CCACHE="" \
		LEX=lex YAAC=bison STRIP=@true \
		NACL_INC_DIR="${EROOT}usr/include/nacl" \
		NACL_LIB_DIR="${EROOT}usr/$(get_libdir)/nacl"
}

src_install() {
	emake PREFIX="${ED}" install
}
