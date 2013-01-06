# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-uploadprogress/pecl-uploadprogress-1.0.1-r1.ebuild,v 1.1 2011/12/14 22:49:36 mabi Exp $

EAPI=3

inherit php-ext-pecl-r2

DESCRIPTION="An extension to track progress of a file upload."
LICENSE="PHP-3.01"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

pkg_postinst() {
	elog "This extension is only known to work on Apache with mod_php."
}
