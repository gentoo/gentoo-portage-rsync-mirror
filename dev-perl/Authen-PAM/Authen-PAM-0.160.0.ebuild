# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-PAM/Authen-PAM-0.160.0.ebuild,v 1.2 2011/09/03 21:05:07 tove Exp $

EAPI=4

MODULE_AUTHOR=NIKIP
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION="Interface to PAM library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="virtual/pam"
DEPEND="${RDEPEND}"

export OPTIMIZE="$CFLAGS"
