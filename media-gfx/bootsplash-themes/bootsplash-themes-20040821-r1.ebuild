# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/bootsplash-themes/bootsplash-themes-20040821-r1.ebuild,v 1.8 2007/08/06 11:10:44 spock Exp $

DESCRIPTION="A collection of Bootsplash themes"
HOMEPAGE="http://www.bootsplash.de/"
THEME_URI="http://www.bootsplash.de/files/themes/"

SRC_URI="${THEME_URI}/Theme-73labAllstar.tar.bz2
	${THEME_URI}/Theme-ASP.tar.bz2
	${THEME_URI}/Theme-ASPLinux.tar.bz2
	${THEME_URI}/Theme-AquaMatrix.tar.bz2
	${THEME_URI}/Theme-Arch.tar.bz2
	${THEME_URI}/Theme-ArchPool.tar.bz2
	${THEME_URI}/Theme-ArchRelief.tar.bz2
	${THEME_URI}/Theme-Ayo.tar.bz2
	${THEME_URI}/Theme-Black.tar.bz2
	${THEME_URI}/Theme-Cargal.tar.bz2
	${THEME_URI}/Theme-Cynapses.tar.bz2
	${THEME_URI}/Theme-DangerGirl.tar.bz2
	${THEME_URI}/Theme-Dark-0.1.tar.bz2
	${THEME_URI}/Theme-Dark-2-0.2.tar.bz2
	${THEME_URI}/Theme-DarkBlue.tar.bz2
	${THEME_URI}/Theme-Debian-Mist.tar.bz2
	${THEME_URI}/Theme-Debian-Tux.tar.bz2
	${THEME_URI}/Theme-Debian-Wave.tar.bz2
	${THEME_URI}/Theme-Debian.tar.bz2
	${THEME_URI}/Theme-Debian2.tar.bz2
	${THEME_URI}/Theme-Debian3.tar.bz2
	${THEME_URI}/Theme-Deflorist.tar.bz2
	${THEME_URI}/Theme-DimmuBorgir.tar.bz2
	${THEME_URI}/Theme-Dragon.tar.bz2
	${THEME_URI}/Theme-ElvinTooka.tar.bz2
	${THEME_URI}/Theme-Emergance.tar.bz2
	${THEME_URI}/Theme-Enterprise-spot.tar.bz2
	${THEME_URI}/Theme-Enterprise.tar.bz2
	${THEME_URI}/Theme-EvenNewerTux.tar.bz2
	${THEME_URI}/Theme-FarCry.tar.bz2
	${THEME_URI}/Theme-FedoraCore2.tar.bz2
	${THEME_URI}/Theme-Flower.tar.bz2
	${THEME_URI}/Theme-Freepia.tar.bz2
	${THEME_URI}/Theme-FrozenBubble.tar.bz2
	${THEME_URI}/Theme-Gentoo-Hornet.tar.bz2
	${THEME_URI}/Theme-Gentoo-LiveCD-2004.0.tar.bz2
	${THEME_URI}/Theme-Gentoo-LiveCD-2004.1.tar.bz2
	${THEME_URI}/Theme-Gentoo-LiveCD-2004.2.tar.bz2
	${THEME_URI}/Theme-Gentoo.tar.bz2
	${THEME_URI}/Theme-Ignite.tar.bz2
	${THEME_URI}/Theme-Jollix.tar.bz2
	${THEME_URI}/Theme-Juicy.tar.bz2
	${THEME_URI}/Theme-Keramik.tar.bz2
	${THEME_URI}/Theme-KillBillTux-Grey.tar.bz2
	${THEME_URI}/Theme-KillBillTux-Yellow.tar.bz2
	${THEME_URI}/Theme-KnoppixKDE.tar.bz2
	${THEME_URI}/Theme-KnoppixLT.tar.bz2
	${THEME_URI}/Theme-Konsole.tar.bz2
	${THEME_URI}/Theme-KuruminOrgBR.tar.bz2
	${THEME_URI}/Theme-Leopard.tar.bz2
	${THEME_URI}/Theme-Linux.tar.bz2
	${THEME_URI}/Theme-MaiHoshino.tar.bz2
	${THEME_URI}/Theme-Mandrake-10.0.tar.bz2
	${THEME_URI}/Theme-Mandrake-9.2.tar.bz2
	${THEME_URI}/Theme-Matrix.tar.bz2
	${THEME_URI}/Theme-MetallTux.tar.bz2
	${THEME_URI}/Theme-Misspingus3.tar.bz2
	${THEME_URI}/Theme-Misspingus4.tar.bz2
	${THEME_URI}/Theme-Momonga.tar.bz2
	${THEME_URI}/Theme-Morphix.tar.bz2
	${THEME_URI}/Theme-NewFreepia.tar.bz2
	${THEME_URI}/Theme-NewLinux.tar.bz2
	${THEME_URI}/Theme-NewTux.tar.bz2
	${THEME_URI}/Theme-NightWorld.tar.bz2
	${THEME_URI}/Theme-Notes.tar.bz2
	${THEME_URI}/Theme-OfficeDesktop.tar.bz2
	${THEME_URI}/Theme-Oneill.tar.bz2
	${THEME_URI}/Theme-OpenSchool.tar.bz2
	${THEME_URI}/Theme-OpenXchange.tar.bz2
	${THEME_URI}/Theme-PLF1.tar.bz2
	${THEME_URI}/Theme-PLF2.tar.bz2
	${THEME_URI}/Theme-PLF5.tar.bz2
	${THEME_URI}/Theme-Pativo.tar.bz2
	${THEME_URI}/Theme-PowerBook.tar.bz2
	${THEME_URI}/Theme-Psychotoxic.tar.bz2
	${THEME_URI}/Theme-RH9.tar.bz2
	${THEME_URI}/Theme-RadiantStar.tar.bz2
	${THEME_URI}/Theme-Redmond.tar.bz2
	${THEME_URI}/Theme-Rojo.tar.bz2
	${THEME_URI}/Theme-Rustenguin.tar.bz2
	${THEME_URI}/Theme-SMGL.tar.bz2
	${THEME_URI}/Theme-Shodan.tar.bz2
	${THEME_URI}/Theme-Slackware.tar.bz2
	${THEME_URI}/Theme-Slackware2.tar.bz2
	${THEME_URI}/Theme-SlackwareLinux.tar.bz2
	${THEME_URI}/Theme-Slide.tar.bz2
	${THEME_URI}/Theme-Spinner.tar.bz2
	${THEME_URI}/Theme-SuSE-7.2.tar.bz2
	${THEME_URI}/Theme-SuSE-7.3.tar.bz2
	${THEME_URI}/Theme-SuSE-8.0.tar.bz2
	${THEME_URI}/Theme-SuSE-8.1.tar.bz2
	${THEME_URI}/Theme-SuSE-8.2.tar.bz2
	${THEME_URI}/Theme-SuSE-Home.tar.bz2
	${THEME_URI}/Theme-SuSE-SLES.tar.bz2
	${THEME_URI}/Theme-SuSE.tar.bz2
	${THEME_URI}/Theme-SwirlPool.tar.bz2
	${THEME_URI}/Theme-ThinkLinux.tar.bz2
	${THEME_URI}/Theme-TuxInfo-Conectiva.tar.bz2
	${THEME_URI}/Theme-TuxInfo-Debian.tar.bz2
	${THEME_URI}/Theme-TuxInfo-Mandrake.tar.bz2
	${THEME_URI}/Theme-TuxInfo-RedHat.tar.bz2
	${THEME_URI}/Theme-TuxInfo-Slackware.tar.bz2
	${THEME_URI}/Theme-TuxInfo-SuSE.tar.bz2
	${THEME_URI}/Theme-TuxInfo.tar.bz2
	${THEME_URI}/Theme-TuxNTosh.tar.bz2
	${THEME_URI}/Theme-UnitedLinux.tar.bz2
	${THEME_URI}/Theme-UrbanVisions-Debian.tar.bz2
	${THEME_URI}/Theme-UrbanVisions-Mandrake.tar.bz2
	${THEME_URI}/Theme-UrbanVisions-SuSE.tar.bz2
	${THEME_URI}/Theme-Vortex.tar.bz2
	${THEME_URI}/Theme-WarmAqua.tar.bz2"
SLOT="0"
LICENSE="freedist"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-gfx/splashutils-1.1.9.6"
DEPEND="net-misc/wget ${RDEPEND}"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# clean it up a little, it's supposed to be config files, not scripts
	elog "Cleaning up the themes"
	find -name *.sh -exec rm -f "{}" \;
	find -maxdepth 2 -name rc.d -exec rm -rf "{}" \;
	find -name rc* -exec rm -f "{}" \;
	find -maxdepth 2 -name 'Slackware 9.1.scripts' -exec rm -rf "{}" \;
	find -maxdepth 2 -name bootloader -exec rm -rf "{}" \;
	find -maxdepth 2 -name lilo -exec rm -rf "{}" \;
	find -maxdepth 2 -name Scripts -exec rm -rf "{}" \;
	find -maxdepth 2 -name example -exec rm -rf "{}" \;
	find -maxdepth 3 -name ".xvpics" -exec rm -rf "{}" \;
	find -name INSTALL -exec rm -f "{}" \;
	rm -rf "./SuSE-Home/var"

	# backup files? no, thank you.
	find -regex '.*~$' -exec rm -f "{}" \;

	# gentooify all paths
	elog "Gentoo-ifying all paths"
	for i in `grep "/etc/bootsplash/themes" -lR *` ; do
		sed -i 's#/etc/bootsplash/themes#/etc/bootsplash#g' "$i"
	done
}

src_install() {
	local mypath

	if has_version "media-gfx/splashutils" ; then
		dodir /etc/splash
		mypath="/etc/splash"
	else
		dodir /etc/bootsplash
		mypath="/etc/bootsplash"
	fi

	cd ${S}

	if has_version "media-gfx/splashutils" ; then
		for i in * ; do
			elog "Converting ${i}"
			[ -z "$(cd ${i} ; find -regex '.*config/bootsplash-[0-9]+x[0-9]+.cfg')" ] && continue
			sed -i "s#/etc/bootsplash#${S}#g" ${i}/config/*.cfg
			bootsplash2fbsplash --bootsplash-path "${S}" --fbsplash-path "${D}/etc/splash" "${i}"
			sed -i "s#${D}#/#g" ${D}/etc/splash/${i}/*.cfg
		done

		# Fix symlinks
		for i in ${D}/etc/splash/*/images/*.{png,jpg} ; do
			if [ -L ${i} ]; then
				tg=`readlink ${i}`
				tg=${tg/${D}//}
				rm -f ${i}
				i=${i/${D}///}
				dosym ${tg} ${i}
			fi
		done
	else
		mv * "${D}/etc/bootsplash"
	fi

	chown -R root:0 "${D}/${mypath}"
	chmod -R o-w "${D}/${mypath}"
}

pkg_postinst() {
	elog "The themes provided in this package come directly from bootsplash.de"
	elog "with only some very basic fixes applied along the way. Some of them"
	elog "might not work properly on your system, some might not support verbose"
	elog "or silent mode, or might only support a single resolution."
	elog ""

	if has_version "media-gfx/splashutils" ; then
		elog "The themes have been automatically converted to a format recognized"
		elog "by splashutils. Note that the conversion process is purely automatical"
		elog "and therefore 'dumb'. Some themes might not work, or work incorrectly."
		elog "If you happen to find a theme that you like, but which doesn't work"
		elog "after it has been automatically converted to the new format, please"
		elog "fix it manually and submit for inclusion into a generic splashutils"
		elog "theme package by posting it on bugzilla (http://bugs.gentoo.org/)"
		elog "or sending it directly to the maintainer of this package."
	else
		elog "When testing the themes, please make sure you're running in a 16bpp"
		elog "mode. 16bpp was the only supported color depth in the original bootsplash"
		elog "patches. The version of the patch that you happen to be using might"
		elog "work with other depths, but only 16bpp is guaranteed to be supported."
		elog ""
		elog "You might want to use:"
		elog "  /sbin/splash -s -u 0 /etc/bootsplash/<theme>/config/<configfile>.cfg"
		elog "to test the themes. Note, that some of them don't support verbose mode."
	fi
}
