# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-I18N-LangTags/perl-I18N-LangTags-0.400.0.ebuild,v 1.4 2015/02/13 22:06:15 jer Exp $

EAPI=5

DESCRIPTION="Virtual for I18N-LangTags"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.20* ~perl-core/I18N-LangTags-${PV} )
	!<perl-core/I18N-LangTags-${PV}
	!>perl-core/I18N-LangTags-${PV}-r999
"
