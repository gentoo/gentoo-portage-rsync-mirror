# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitstats/gitstats-100711.ebuild,v 1.2 2010/07/23 07:46:04 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Statistics generator for git"
HOMEPAGE="http://gitstats.sourceforge.net/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sci-visualization/gnuplot[gd]
	dev-vcs/git"
DEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed "s:basedir = os.path.dirname(os.path.abspath(__file__)):basedir = '/usr/share/gitstats':g" \
	-i gitstats || die "failed to fix static files path"
}

src_compile() {
	:;
}

src_install() {
	emake PREFIX="${D}"/usr VERSION="${PV}" install || die
	dodoc doc/{README,*.txt} || die "doc install failed"
}
