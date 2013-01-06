# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.40.0.ebuild,v 1.9 2012/09/02 18:07:13 armin76 Exp $

EAPI=4

MODULE_AUTHOR=TJMATHER
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Regular expressions for XML tokens"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.29"
DEPEND="${RDEPEND}"

SRC_TEST="do"
