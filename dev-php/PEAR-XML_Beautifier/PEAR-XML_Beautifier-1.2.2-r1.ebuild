# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-XML_Beautifier/PEAR-XML_Beautifier-1.2.2-r1.ebuild,v 1.1 2014/10/11 17:38:08 grknight Exp $

EAPI=5

inherit php-pear-r1

DESCRIPTION="Adds indentation and linebreaks, replace entities, formats comments and makes XML easier to read"
LICENSE="PHP-2.02"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-XML_Util
	dev-php/PEAR-XML_Parser"
