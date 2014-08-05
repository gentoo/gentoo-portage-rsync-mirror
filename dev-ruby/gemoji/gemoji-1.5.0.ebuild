# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gemoji/gemoji-1.5.0.ebuild,v 1.2 2014/08/05 16:00:56 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_EXTRADOC="MAINTAINING.md README.md"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Emoji images and names"
HOMEPAGE="https://github.com/github/gemoji"
SRC_URI="https://github.com/github/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
