# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/marrie/marrie-0.3.1.ebuild,v 1.2 2014/07/06 12:53:19 mgorny Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

HG_ECLASS=""
if [[ ${PV} = *9999* ]]; then
	HG_ECLASS="mercurial"
	EHG_REPO_URI="http://hg.rafaelmartins.eng.br/marrie/"
fi

inherit distutils ${HG_ECLASS}

DESCRIPTION="A simple podcast client that runs on the Command Line Interface"
HOMEPAGE="http://projects.rafaelmartins.eng.br/marrie/"

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
if [[ ${PV} = *9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
fi

LICENSE="BSD"
SLOT="0"
IUSE="doc"

RDEPEND="dev-python/feedparser"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

PYTHON_MODNAME="marrie.py"

src_compile() {
	distutils_src_compile
	if use doc; then
		rst2html.py README.rst marrie.html || die "rst2html.py failed"
	fi
}

src_install() {
	distutils_src_install
	if use doc; then
		dohtml marrie.html
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	elog
	elog "You'll need a media player and a file downloader."
	elog "Recommended packages: net-misc/wget and media-video/mplayer"
	elog
}
