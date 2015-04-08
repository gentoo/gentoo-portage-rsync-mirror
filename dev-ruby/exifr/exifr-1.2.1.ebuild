# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/exifr/exifr-1.2.1.ebuild,v 1.1 2015/03/03 18:21:31 mrueg Exp $

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21 ruby22"

RUBY_FAKEGEM_DOCDIR="doc/api"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="A library to read EXIF info from JPEG and TIFF images"
HOMEPAGE="http://exifr.rubyforge.org/"

# License is not specified in source distribution but is in the GitHub
# repository.
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
