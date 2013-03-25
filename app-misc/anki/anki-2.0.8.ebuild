# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/anki/anki-2.0.8.ebuild,v 1.2 2013/03/25 04:50:27 tomka Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"

inherit eutils python

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="http://ichi2.net/anki/"
SRC_URI="http://ankisrs.net/download/mirror/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex +recording +sound"

RDEPEND="dev-python/PyQt4[X,svg,webkit]
	 >=dev-python/httplib2-0.7.4
	 dev-python/beautifulsoup:python-2
	 recording? ( media-sound/lame
				  >=dev-python/pyaudio-0.2.4 )
	 sound? ( media-video/mplayer )
	 latex? ( app-text/texlive
			  app-text/dvipng )"
DEPEND=""

pkg_setup(){
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	rm -r thirdparty || die
	python_convert_shebangs -r 2 .
}

# Nothing to configure or compile
src_configure() {
	true;
}

src_compile() {
	true;
}

src_install() {
	exeinto /usr/bin/
	doexe anki/anki

	doicon ${PN}.png
	domenu ${PN}.desktop
	doman ${PN}.1

	dodoc README README.development
	insinto "$(python_get_sitedir)"
	doins -r aqt anki
}

pkg_preinst() {
	if has_version "<app-misc/anki-2" ; then
		elog "Anki 2 is a rewrite of Anki with many new features and"
		elog "a new database format.  On the first run your decks are"
		elog "converted to the new format and a backup of your Anki-1"
		elog "decks is created.  Please read the following:"
		elog "http://ankisrs.net/anki2.html"
	fi
}
