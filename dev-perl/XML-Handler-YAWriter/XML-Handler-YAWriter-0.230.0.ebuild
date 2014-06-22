# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Handler-YAWriter/XML-Handler-YAWriter-0.230.0.ebuild,v 1.3 2014/06/22 18:45:11 maekke Exp $

EAPI=4

MODULE_AUTHOR=KRAEHE
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"

LICENSE="GPL-2" # GPL
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND=">=dev-perl/libxml-perl-0.07-r1"
DEPEND="${RDEPEND}"
