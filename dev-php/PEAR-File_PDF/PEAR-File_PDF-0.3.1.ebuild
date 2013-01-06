# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_PDF/PEAR-File_PDF-0.3.1.ebuild,v 1.1 2007/11/15 18:09:08 jokey Exp $

inherit php-pear-r1

DESCRIPTION="PDF generation using only PHP."
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( dev-php/PEAR-HTTP_Download )"
