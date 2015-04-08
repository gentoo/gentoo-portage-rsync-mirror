# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/perlkde/perlkde-4.14.3.ebuild,v 1.5 2015/02/17 11:06:36 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Perl bindings"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="akonadi attica debug kate okular nepomuk test"

RDEPEND="
	>=dev-lang/perl-5.10.1:=
	$(add_kdebase_dep perlqt)
	$(add_kdebase_dep smokekde 'akonadi?,attica?,kate?,nepomuk?,okular?')
	nepomuk? ( >=dev-libs/soprano-2.9.0 )
"
DEPEND="${RDEPEND}
	test? ( dev-perl/List-MoreUtils )
"

PATCHES=( "${FILESDIR}/${PN}-4.11.3-vendor.patch" )

RESTRICT="test"
# yes they all fail.

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_with attica LibAttica)
		$(cmake-utils_use_disable kate)
		$(cmake-utils_use_with nepomuk)
		$(cmake-utils_use_with nepomuk Soprano)
		$(cmake-utils_use_with okular)
	)
	kde4-base_src_configure
}
