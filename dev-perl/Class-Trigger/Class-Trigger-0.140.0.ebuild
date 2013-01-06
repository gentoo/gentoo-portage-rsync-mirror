# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Trigger/Class-Trigger-0.140.0.ebuild,v 1.8 2012/09/01 11:22:25 grobian Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Mixin to add / call inheritable triggers"

SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/IO-stringy"
DEPEND="${RDEPEND}"

SRC_TEST="do"
