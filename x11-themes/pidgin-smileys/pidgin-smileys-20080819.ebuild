# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/pidgin-smileys/pidgin-smileys-20080819.ebuild,v 1.3 2013/05/01 15:20:14 xarthisius Exp $

DESCRIPTION="Pidgin smiley themes"
HOMEPAGE="http://pidgin.im/"
SRC_URI="http://gaim.sourceforge.net/exhaustive.tar.gz
	http://www.the-kgb.org/~reivec/Bugeyes.tar.gz
	http://www.the-kgb.org/~reivec/CrystalAIM.tar.gz
	http://www.the-kgb.org/~reivec/EasterAIM.tar.gz
	http://www.gnomepro.com/smallsmiles/SmallSmiles.tar.gz
	http://users.skynet.be/xterm/tweak-0.1.3.tar.gz
	http://hejieshijie.net/files/Maya.tar.gz
	http://stephane.pontier.free.fr/projects/TrillyPro.tgz
	http://www.rit.edu/~kod1929/Aqua.tar.gz
	http://www.rit.edu/~kod1929/Jimmac_2.tar.gz
	http://smart-idiot.no-ip.com/smilies/smart.zip
	http://www.geocities.com/drewd146/Hand_Drawn.zip
	http://www.zicklepop.com/downloads/dudes.zip
	http://www.pfarroli.de/monne/piko/icq_lite.tar.gz
	http://www.mbpublish.de/downloads/icq-lite-4_smileys.tar.gz
	http://kolobok.us/files/user/kolobok_for_gaim.tar.gz"

LICENSE="as-is"
IUSE=""
SLOT="0"

KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
RDEPEND="net-im/pidgin"
DEPEND="app-arch/unzip
	!x11-themes/pidgin-penguins-smileys"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	# Delete all files not theme-related
	find "${S}" -type f ! -name '*.png' -and ! -name '*.gif' -and ! -name '*.jpg' -and ! -name 'theme' -delete
}

src_install() {
	dodir /usr/share/pixmaps/pidgin/emotes
	cp -r "${S}"/* "${D}"/usr/share/pixmaps/pidgin/emotes
}

pkg_postinst() {
	einfo "To request a new theme to be added, file a request at"
	einfo "http://bugs.gentoo.org/"
}
