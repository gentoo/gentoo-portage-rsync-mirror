# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/gnuvd/gnuvd-1.0.11.ebuild,v 1.2 2014/08/10 02:33:08 patrick Exp $

EAPI=4

DESCRIPTION="gnuvd is a command line interface to the Van Dale(tm) on-line Dutch dictionary"
HOMEPAGE="http://www.djcbsoftware.nl/code/gnuvd"
SRC_URI="${HOMEPAGE}/${P/_/}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${P/_/}"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README README.nl )
