# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Tree/PEAR-Tree-0.3.2.ebuild,v 1.9 2007/12/06 00:56:45 jokey Exp $

inherit php-pear-r1

DESCRIPTION="Generic tree management, currently supports DB and XML as data sources."
LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="minimal"
RDEPEND="!minimal? ( >=dev-php/PEAR-DB-1.7.11
			>=dev-php/PEAR-XML_Parser-1.2.8 )"
