# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-I18N-LangTags/perl-I18N-LangTags-0.380.0.ebuild,v 1.1 2014/07/22 22:40:46 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for I18N-LangTags"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.16* ~perl-core/I18N-LangTags-${PV} )
	!<perl-core/I18N-LangTags-${PV}
	!>perl-core/I18N-LangTags-${PV}-r999
"
