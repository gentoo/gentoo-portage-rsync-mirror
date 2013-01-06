# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/regexp-common/regexp-common-2011121001.0.0.ebuild,v 1.6 2012/05/26 19:02:22 armin76 Exp $

EAPI=4

MY_PN=Regexp-Common
MODULE_AUTHOR=ABIGAIL
MODULE_VERSION=2011121001
inherit perl-module

DESCRIPTION="Provide commonly requested regular expressions"

LICENSE="|| ( Artistic Artistic-2 MIT BSD )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
