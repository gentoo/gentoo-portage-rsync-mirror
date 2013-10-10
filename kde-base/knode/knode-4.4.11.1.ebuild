# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knode/knode-4.4.11.1.ebuild,v 1.9 2013/10/10 05:26:51 creffett Exp $

EAPI=4

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A newsreader for KDE"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug +handbook"

# test fails, last checked for 4.2.96
RESTRICT=test

DEPEND="
	$(add_kdebase_dep kdepimlibs '' 4.6)
	$(add_kdebase_dep libkdepim)
	$(add_kdebase_dep libkpgp)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkpgp/
"

KMLOADLIBS="libkdepim"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kioslave/news
		"
	fi

	kde4-meta_src_unpack
}
