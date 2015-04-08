# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/gitstats/gitstats-9999.ebuild,v 1.4 2013/10/24 17:21:54 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1 git-2

DESCRIPTION="Statistics generator for git"
HOMEPAGE="http://gitstats.sourceforge.net/"
SRC_URI=""
EGIT_REPO_URI="
	git://repo.or.cz/${PN}.git
	http://repo.or.cz/r/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sci-visualization/gnuplot[gd]
	dev-vcs/git"
DEPEND=""

src_prepare() {
	sed \
		-e "s:basedir = os.path.dirname(os.path.abspath(__file__)):basedir = '${EPREFIX}/usr/share/gitstats':g" \
	-i gitstats || die "failed to fix static files path"
}

src_compile() {
	:;
}

src_install() {
	emake PREFIX="${D}"/usr VERSION="${PV}" install
	dodoc doc/{README,*.txt}
	python_replicate_script "${ED}"/usr/bin/${PN}
}
