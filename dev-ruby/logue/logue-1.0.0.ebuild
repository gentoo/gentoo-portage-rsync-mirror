# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/logue/logue-1.0.0.ebuild,v 1.1 2013/11/30 09:37:39 graaff Exp $

EAPI=5
USE_RUBY="ruby19 jruby"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="Features.txt History.txt README.md"

inherit ruby-fakegem

DESCRIPTION="A module that adds logging/trace functionality"
HOMEPAGE="https://github.com/jpace/logue"

SRC_URI="https://github.com/jpace/logue/archive/v${PV}.tar.gz -> ${PN}-git-${PV}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/rainbow-1.1.4"
