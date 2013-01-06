# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-svn/pecl-svn-1.0.1.ebuild,v 1.1 2012/02/12 15:38:31 mabi Exp $

EAPI=4

PHP_EXT_NAME="svn"

inherit php-ext-pecl-r2

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP Bindings for the Subversion Revision control system."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

# subversion-1.7 breaks the build (bug #402921)
DEPEND="<dev-vcs/subversion-1.7"
RDEPEND="${DEPEND}"
