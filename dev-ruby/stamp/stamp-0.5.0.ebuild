# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/stamp/stamp-0.5.0.ebuild,v 1.1 2013/11/20 15:33:30 mrueg Exp $

EAPI=5
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_RECIPE_TEST="cucumber"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

DESCRIPTION="Date and time formatting for humans"
HOMEPAGE="https://github.com/jeremyw/stamp"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""
