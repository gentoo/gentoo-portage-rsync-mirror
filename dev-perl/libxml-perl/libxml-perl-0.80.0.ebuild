# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libxml-perl/libxml-perl-0.80.0.ebuild,v 1.3 2012/05/18 09:02:15 aballier Exp $

EAPI=4

MODULE_AUTHOR=KMACLEOD
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Collection of Perl modules for working with XML"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.29"
DEPEND="${RDEPEND}"
