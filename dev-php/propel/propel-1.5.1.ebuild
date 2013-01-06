# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/propel/propel-1.5.1.ebuild,v 1.1 2011/12/14 22:54:04 mabi Exp $

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Object Persistence Layer for PHP 5."
HOMEPAGE="http://propel.phpdb.org/trac/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="~dev-php/propel-generator-${PV}
		~dev-php/propel-runtime-${PV}"
