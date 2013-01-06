# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_PDF/PEAR-File_PDF-0.3.2.ebuild,v 1.1 2008/03/03 16:50:15 jokey Exp $

inherit php-pear-r1

DESCRIPTION="PDF generation using only PHP, without requiring any external libraries."
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( dev-php/PEAR-HTTP_Download )"
