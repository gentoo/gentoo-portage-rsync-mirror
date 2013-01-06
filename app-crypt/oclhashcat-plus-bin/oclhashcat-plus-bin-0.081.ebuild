# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/oclhashcat-plus-bin/oclhashcat-plus-bin-0.081.ebuild,v 1.3 2012/07/04 17:51:22 zerochaos Exp $

EAPI=4

inherit eutils pax-utils

DESCRIPTION="An opencl multihash cracker"
HOMEPAGE="http://hashcat.net/oclhashcat-plus/"

MY_P="oclHashcat-plus-${PV}"
SRC_URI="amd64? ( http://hashcat.net/files/${MY_P}-64.7z ) \
	 x86? ( http://hashcat.net/files/${MY_P}-32.7z )"

LICENSE="hashcat"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE_VIDEO_CARDS="video_cards_fglrx
	video_cards_nvidia"

IUSE="${IUSE_VIDEO_CARDS}"

RDEPEND="sys-libs/zlib
	video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-290.40 )
	video_cards_fglrx?  ( >=x11-drivers/ati-drivers-12.4 )"
DEPEND="${RDEPEND}
	app-arch/p7zip"

#S="${WORKDIR}/${MY_P}"
#temporary hack needed due to 0.81 patch release
S="${WORKDIR}/oclHashcat-plus-0.08"

RESTRICT="strip"
QA_PREBUILT="*Hashcat-plus*.bin"

src_install() {
	dodoc docs/*
	rm -r *.exe docs || die
	#patches already in aircrack-ng
	rm -r contrib/aircrack-ng_r1959 || die

	#the current release (0.08) seperates 64bit from 32 bit, will he stay with this?
	#if ! use amd64; then
	#	rm oclHashcat-plus64.bin || die
	#	rm cudaHashcat-plus64.bin || die
	#	rm kernels/4098/*64* kernels/4318/*64* || die
	#fi
	#if ! use x86; then
	#	rm oclHashcat-plus32.bin || die
	#	rm cudaHashcat-plus32.bin || die
	#	rm kernels/4098/*32* kernels/4318/*32* || die
	#fi
	if ! use video_cards_fglrx; then
		rm -r kernels/4098 || die
		rm oclHashcat-plus*.bin || die
	fi
	if ! use video_cards_nvidia; then
		rm -r kernels/4318 || die
		rm cudaHashcat-plus*.bin || die
	fi
	pax-mark m *Hashcat-plus*.bin

	insinto /opt/${PN}
	doins -r "${S}"/* || die "Copy files failed"

	dodir /opt/bin

	cat <<-EOF > "${ED}"/opt/bin/oclhashcat-plus
		#! /bin/sh
		echo "oclHashcat-plus and all related files have been installed in /opt/${PN}"
		echo "Please run one of the following binaries to use gpu accelerated hashcat:"
	EOF

	for x in oclHashcat-plus64.bin oclHashcat-plus32.bin cudaHashcat-plus64.bin cudaHashcat-plus32.bin
	do
		if [ -f "${ED}"/opt/${PN}/${x} ]
		then
			case "${x}" in
				oclHashcat-plus64.bin)
					echo "echo '64 bit ATI accelerated \"oclHashcat-plus64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				oclHashcat-plus32.bin)
					echo "echo '32 bit ATI accelerated \"oclHashcat-plus32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				cudaHashcat-plus64.bin)
					echo "echo '64 bit NVIDIA accelerated \"cudaHashcat-plus64.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
				cudaHashcat-plus32.bin)
					echo "echo '32 bit NVIDIA accelerated \"cudaHashcat-plus32.bin\"'" >> "${ED}"/opt/bin/oclhashcat-plus
					;;
			esac

			fperms +x /opt/${PN}/${x}

			cat <<-EOF > "${ED}"/opt/bin/${x}
				#! /bin/sh
				cd /opt/${PN}
				echo "Warning: ${x} is running from /opt/${PN} so be careful of relative paths."
				exec ./${x} "\$@"
			EOF

			fperms +x /opt/bin/${x}

		fi
	done

	fperms +x /opt/bin/oclhashcat-plus
	fowners root:video /opt/${PN}
	einfo "oclhashcat-plus can be run as user if you are in the video group"
}
