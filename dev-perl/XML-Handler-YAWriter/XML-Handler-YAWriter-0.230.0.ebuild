# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Handler-YAWriter/XML-Handler-YAWriter-0.230.0.ebuild,v 1.2 2011/09/03 21:04:54 tove Exp $

EAPI=4

MODULE_AUTHOR=KRAEHE
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="A Perl module providing a simple API to parsed XML instances"

LICENSE="GPL-2" # GPL
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND=">=dev-perl/libxml-perl-0.07-r1"
DEPEND="${RDEPEND}"
