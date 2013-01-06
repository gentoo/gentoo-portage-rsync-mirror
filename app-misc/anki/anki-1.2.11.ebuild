# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/anki/anki-1.2.11.ebuild,v 1.4 2012/06/20 15:06:38 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="http://ichi2.net/anki/"
SRC_URI="http://anki.googlecode.com/files/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="furigana +graph latex recording +sound"

# beautifulsoup-4 is not supported in 1.2.11
RDEPEND="
	<dev-python/beautifulsoup-4
	>=dev-python/PyQt4-4.7[X,svg,webkit]
	>=dev-python/sqlalchemy-0.5.3
	>=dev-python/simplejson-1.7.3
	|| ( >=dev-python/pysqlite-2.3.0 >=dev-lang/python-2.5[sqlite] )
	latex? ( app-text/dvipng )
	furigana? (
		dev-python/mecab-python
		app-i18n/kakasi
	)
	graph? (
		dev-python/numpy
		>=dev-python/matplotlib-0.91.2
	)
	recording? (
		media-sound/sox
		dev-python/pyaudio
		media-sound/lame
	)
	sound? ( media-video/mplayer )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="anki ankiqt"

src_prepare() {
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile
	cd libanki
	distutils_src_compile
}

src_install() {
	distutils_src_install
	cd libanki
	distutils_src_install
	cd ..

	doicon icons/${PN}.png || die
	make_desktop_entry ${PN} ${PN} ${PN} "Education"
}
