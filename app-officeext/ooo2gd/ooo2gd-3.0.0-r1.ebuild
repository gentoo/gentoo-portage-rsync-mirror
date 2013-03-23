# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-officeext/ooo2gd/ooo2gd-3.0.0-r1.ebuild,v 1.1 2013/03/23 10:19:32 scarabeus Exp $

EAPI=5

OFFICE_REQ_USE="java"

OFFICE_EXTENSIONS=(
	"${PN}_${PV}.oxt"
)
inherit office-ext-r1

DESCRIPTION="Extension for export to Google docs, zoho and WebDAV"
HOMEPAGE="http://code.google.com/p/ooo2gd/"
SRC_URI="http://ooo2gd.googlecode.com/files/${PN}_${PV}.oxt"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
