# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/gpe-contacts/gpe-contacts-0.49.ebuild,v 1.2 2009/09/11 11:28:13 flameeyes Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe autotools

DESCRIPTION="The GPE Contacts Manager"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE} dbus"

GPE_DOCS="ChangeLog"
GPECONF="${GPECONF} $(use_enable dbus)"

RDEPEND="${RDEPEND}
	gpe-base/libgpewidget
	gpe-base/libgpevtype
	gpe-base/libgpepimc
	gpe-base/libcontactsdb
	gpe-base/libmimedir
	dev-db/sqlite
	dbus? ( dev-libs/dbus-glib )"

DEPEND="${DEPEND}
	${RDEPEND}"

src_unpack() {
	gpe_src_unpack "$@"

	# fixes make check
	echo "main-hildon.c" >> po/POTFILES.skip || die
	eautoreconf
}
