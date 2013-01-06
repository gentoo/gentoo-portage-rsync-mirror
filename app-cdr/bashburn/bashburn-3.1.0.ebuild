# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bashburn/bashburn-3.1.0.ebuild,v 1.5 2012/04/01 15:44:19 armin76 Exp $

EAPI=4

MY_P=BashBurn-${PV}

DESCRIPTION="A shell script for burning optical media"
HOMEPAGE="http://bashburn.dose.se/"
SRC_URI="http://bashburn.dose.se/index.php?s=file_download&id=25 -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}
	app-cdr/cdrdao
	app-cdr/dvd+rw-tools
	media-libs/flac
	media-sound/cdparanoia
	media-sound/lame
	media-sound/mpg123
	media-sound/normalize
	media-sound/vorbis-tools
	virtual/cdrtools
	virtual/eject"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# Fix for "warning: jobserver unavailable: using -j1."
	sed -i -e 's:make -C:$(MAKE) -C:' Makefile || die
}

src_install() {
	./Install.sh --prefix="${D}"/usr || die

	# Remove /var/tmp/portage from installed script
	sed -i \
		-e "/BBROOTDIR=/s:'.*':'/usr/lib/Bashburn/lib':" \
		"${ED}"/usr/lib/Bashburn/lib/BashBurn.sh || die

	rm -rf "${ED}"/usr/lib/Bashburn/lib/docs
	dodoc docs/{ChangeLog,CREDITS,FAQ,HOWTO,README,TODO,TRANSLATION_RULE}
}
