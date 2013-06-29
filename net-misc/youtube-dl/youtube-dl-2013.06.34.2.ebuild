# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2013.06.34.2.ebuild,v 1.3 2013/06/29 20:20:09 floppym Exp $

EAPI=5

PYTHON_COMPAT=(python{2_6,2_7,3_3})
DISTUTILS_SINGLE_IMPL=true
inherit bash-completion-r1 distutils-r1 eutils

DESCRIPTION="Download videos from YouTube.com (and mores sites...)"
HOMEPAGE="http://rg3.github.com/youtube-dl/"
SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="offensive test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[coverage(+)] )"

S="${WORKDIR}/${PN}"

src_prepare() {
	if ! use offensive; then
		epatch "${FILESDIR}"/${P}-offensive.patch
		rm \
			youtube_dl/extractor/pornotube.py \
			youtube_dl/extractor/redtube.py \
			youtube_dl/extractor/xhamster.py \
			youtube_dl/extractor/xnxx.py \
			youtube_dl/extractor/xvideos.py \
			youtube_dl/extractor/youjizz.py \
			youtube_dl/extractor/youporn.py \
			|| die
	fi
}

src_compile() {
	distutils-r1_src_compile
}

src_test() {
	emake test
}

src_install() {
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc CHANGELOG README.txt
	doman ${PN}.1
	newbashcomp ${PN}.bash-completion ${PN}
	python_fix_shebang "${ED}"
}
