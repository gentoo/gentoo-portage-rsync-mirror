# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize-FormFiller/WWW-Mechanize-FormFiller-0.100.0-r1.ebuild,v 1.1 2014/08/24 02:07:01 axs Exp $

EAPI=5

MODULE_AUTHOR=CORION
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Framework to automate HTML forms "

SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND="dev-perl/Data-Random
	|| (
		( >dev-perl/libwww-perl-6 dev-perl/HTML-Form )
		<dev-perl/libwww-perl-6
	)"
RDEPEND="${DEPEND}"

SRC_TEST="do"
