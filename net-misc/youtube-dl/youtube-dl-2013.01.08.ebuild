# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2013.01.08.ebuild,v 1.3 2013/01/09 15:15:04 jer Exp $

EAPI=5
PYTHON_COMPAT=(python{2_5,2_6,2_7})

inherit bash-completion-r1 python-single-r1

DESCRIPTION="A small command-line program to download videos from YouTube."
HOMEPAGE="http://rg3.github.com/youtube-dl/"
SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

# test_ComedyCentral hangs in this version:
# nosetests --verbose --with-coverage --cover-package=youtube_dl --cover-html test
#DEPEND="test? ( dev-python/nose[coverage] )"

S="${WORKDIR}/${PN}"

src_install() {
	rm -vf youtube_dl/*.py[co]
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc CHANGELOG README.txt
	doman ${PN}.1
	dobashcomp ${PN}.bash-completion ${PN}
}
