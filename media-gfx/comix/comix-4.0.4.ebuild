# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/comix/comix-4.0.4.ebuild,v 1.2 2012/09/14 10:33:16 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="A GTK image viewer specifically designed to handle comic books."
HOMEPAGE="http://comix.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
LANGS=" ca cs es fr hr hu id ja ko pl pt_BR ru sv zh_CN zh_TW"
IUSE="rar $(echo ${LANGS//\ /\ linguas_})"

RDEPEND=">=dev-python/imaging-1.1.5
	>=dev-python/pygtk-2.12
	rar? ( || ( app-arch/unrar app-arch/rar ) )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# do not install .pyc into /usr/share
	local pythondir="$(python_get_sitedir)/comix"
	pythondir="${pythondir/\/usr\/}"
	sed -i -e "s:share/comix/src:${pythondir}:g" install.py || die
	python_convert_shebangs -r 2 install.py mime/comicthumb src/comix.py
}

src_install() {
	dodir /usr
	python2 install.py install --no-mime --dir "${D}"usr || die

	insinto /usr/share/mime/packages
	doins mime/comix.xml

	insinto /etc/gconf/schemas
	doins mime/comicbook.schemas

	dobin mime/comicthumb
	dodoc ChangeLog README

	local lang
	for lang in ${LANGS} ; do
		use linguas_${lang} || rm -r "${D}"/usr/share/locale/${lang}
	done
}
