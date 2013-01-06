# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxcd/roxcd-0.5.4-r2.ebuild,v 1.5 2007/11/16 15:01:35 drac Exp $

ROX_LIB_VER=1.9.14
inherit rox

MY_PN="RoxCD"
DESCRIPTION="RoxCD - A CD Player/Ripper for the ROX Desktop"
HOMEPAGE="http://www.rdsarts.com/code/roxcd"
SRC_URI="http://www.rdsarts.com/code/roxcd/files/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

APPNAME=${MY_PN}
APPCATEGORY="AudioVideo;Audio;Player"
S=${WORKDIR}

src_unpack() {
	unpack ${A}

	# Remove this unneeded '.-preclean' directory
	cd ${APPNAME}
	rm -fr .-preclean

	# Move the licences just into 'Help'
	cd Help
	mv Licenses-Text/* ./
	rm -fr Licenses-Text
}
