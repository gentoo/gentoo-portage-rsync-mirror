# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_umask/mod_umask-0.1.0.ebuild,v 1.5 2007/01/15 19:31:28 chtekk Exp $

inherit apache-module

KEYWORDS="amd64 x86"

DESCRIPTION="Sets the Unix umask of the Apache2 webserver process after it has started."
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_umask/"
SRC_URI="http://www.apache.org/~pquerna/modules/${P}.tar.bz2"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="47_${PN}"
APACHE2_MOD_DEFINE="UMASK"

need_apache2
