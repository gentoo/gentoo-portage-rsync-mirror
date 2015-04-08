# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgtune/pgtune-0.9.3-r1.ebuild,v 1.1 2012/11/11 17:27:48 titanofold Exp $
EAPI=4

inherit eutils

DESCRIPTION="A postgresql settings tuning wizard"

HOMEPAGE="http://pgfoundry.org/projects/pgtune/"
SRC_URI="http://pgfoundry.org/frs/download.php/2449/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e '1 s|python|python2|' -i pgtune
}

src_install() {
	mkdir -p "${D}/usr/bin"
	mkdir -p "${D}/usr/share/doc/${P}"
	cp "${S}/pgtune" "${D}/usr/bin/pgtune" || die
	for i in COPYRIGHT  README  TODO  pg_settings-8.4-32  pg_settings-8.4-64 pgtune-settingsdir.patch  pgtune.spec  postgresql.conf.sample; do
		cp "${S}/${i}" "${D}/usr/share/doc/${P}" || die
	done
	docompress -x /usr/share/doc
}
