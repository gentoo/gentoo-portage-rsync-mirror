# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-ex-formfactory/gtk2-ex-formfactory-0.670.0.ebuild,v 1.6 2012/03/31 12:07:55 armin76 Exp $

EAPI=4

MODULE_AUTHOR=JRED
MODULE_VERSION=0.67
MY_PN=Gtk2-Ex-FormFactory
inherit perl-module

DESCRIPTION="Gtk2 FormFactory"
HOMEPAGE="http://www.exit1.org/Gtk2-Ex-FormFactory/ ${HOMEPAGE}"

LICENSE="|| ( LGPL-2.1 LGPL-3 )" #LGPL-2.1+
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
