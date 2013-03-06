# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/the_silver_searcher/the_silver_searcher-0.14.ebuild,v 1.1 2013/03/06 03:29:45 jdhore Exp $

EAPI=5
inherit autotools bash-completion-r1

DESCRIPTION="A code-searching tool similar to ack, but faster"
HOMEPAGE="http://github.com/ggreer/the_silver_searcher"
SRC_URI="https://github.com/ggreer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/libpcre"
DEPEND="${RDEPEND}
		virtual/pkgconfig"

DOCS="README.md"

src_prepare() {
	sed -i -e 's/ag\.bashcomp\.sh//' Makefile.am || die
	eautoreconf
}

src_install() {
	default
	newbashcomp ag.bashcomp.sh ag
}
