# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fslint/fslint-2.42.ebuild,v 1.1 2013/03/28 15:15:00 tomwij Exp $

EAPI="5"

PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="An utility to find various forms of lint on a filesystem."
HOMEPAGE="http://www.pixelbeat.org/${PN}/"
SRC_URI="http://www.pixelbeat.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="dev-python/pygtk:2"

src_prepare() {
	python_convert_shebangs -r 2 .

	# Change some paths to make fslint-gui run when installed in /usr/bin.
	sed -e "s:^liblocation=.*$:liblocation='${EROOT}usr/share/${PN}' #Gentoo:" \
		-e "s:^locale_base=.*$:locale_base=None #Gentoo:" \
		-i fslint-gui || die "sed failed"
}

src_install() {
	insinto /usr/share/${PN}
	doins ${PN}{.glade,.gladep,_icon.png}

	insinto /usr/share/${PN}/${PN}
	doins ${PN}/find*
	doins ${PN}/${PN}
	doins ${PN}/zipdir

	insinto /usr/share/${PN}/${PN}/fstool/
	doins ${PN}/fstool/*

	insinto /usr/share/${PN}/${PN}/supprt/
	doins ${PN}/supprt/*

	insinto /usr/share/${PN}/${PN}/supprt/rmlint
	doins ${PN}/supprt/rmlint/*

	fperms +x /usr/share/${PN}/${PN}/find*
	fperms +x /usr/share/${PN}/${PN}/zipdir
	fperms +x /usr/share/${PN}/${PN}/fstool/*
	fperms +x /usr/share/${PN}/${PN}/supprt/*
	fperms +x /usr/share/${PN}/${PN}/supprt/rmlint/{fixdup,merge_hardlinks}

	dobin ${PN}-gui

	doicon ${PN}_icon.png
	domenu ${PN}.desktop

	dodoc doc/{FAQ,NEWS,README,TODO}
	doman man/{fslint.1,fslint-gui.1}

	if use nls ; then
		cd po
		emake DESTDIR="${D}" install
	fi
}
