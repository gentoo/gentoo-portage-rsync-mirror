# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/youtube-dl/youtube-dl-2015.02.11.ebuild,v 1.1 2015/02/12 10:22:17 jer Exp $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_3,3_4})
DISTUTILS_SINGLE_IMPL=true
inherit bash-completion-r1 distutils-r1 eutils

DESCRIPTION="Download videos from YouTube.com (and more sites...)"
HOMEPAGE="http://rg3.github.com/youtube-dl/"
SRC_URI="http://youtube-dl.org/downloads/${PV}/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="offensive test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[coverage(+)] )
"

S="${WORKDIR}/${PN}"

src_prepare() {
	if ! use offensive; then
		sed -i -e "/__version__/s|'$|-gentoo_no_offensive_sites'|g" \
			youtube_dl/version.py || die
		local xxx=(
			alphaporno anysex behindkink drtuber empflix eporner eroprofile
			extremetube fourtube foxgay goshgay hellporno hentaistigma
			hornbunny keezmovies mofosex motherless pornhd pornhub pornotube
			pornoxo redtube sexykarma sexu sunporno slutload spankwire thisav
			tnaflix trutube tube8 vporn xbef xhamster xnxx xtube xvideos
			xxxymovies youjizz youporn
		)
		sed -i -e $( printf '/%s/d;' ${xxx[@]} ) youtube_dl/extractor/__init__.py || die
		rm $( printf 'youtube_dl/extractor/%s.py ' ${xxx[@]} ) \
			test/test_age_restriction.py || die
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
	dodoc README.txt
	doman ${PN}.1
	newbashcomp ${PN}.bash-completion ${PN}
	python_fix_shebang "${ED}"
}
