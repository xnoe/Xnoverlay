# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools out-of-source virtualx

DESCRIPTION="Resloved i3-gapps"
HOMEPAGE="https://github.com/resloved/i3/"
SRC_URI="https://github.com/resloved/i3/archive/shape.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~amd64 ~arm64 ~x86"
IUSE="doc debug test"

CDEPEND="dev-libs/libev
	dev-libs/libpcre
	dev-libs/yajl
	x11-libs/libxcb[xkb]
	x11-libs/libxkbcommon[X]
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-xrm
	x11-misc/xkeyboard-config
	x11-libs/cairo[X,xcb(+)]
	x11-libs/pango[X]"
DEPEND="${CDEPEND}
	test? (
		dev-perl/AnyEvent
		dev-perl/X11-XCB
		dev-perl/Inline
		dev-perl/Inline-C
		dev-perl/IPC-Run
		dev-perl/ExtUtils-PkgConfig
		dev-perl/local-lib
		virtual/perl-Test-Simple
		x11-base/xorg-server[xephyr]
		x11-misc/xvfb-run
	)"
RDEPEND="${CDEPEND}
	dev-lang/perl
	dev-perl/AnyEvent-I3
	dev-perl/JSON-XS"
BDEPEND="virtual/pkgconfig"

# Test without debug will apply optimization levels, which results
# in type-punned pointers - which in turn causes test failures.
REQUIRED_USE="test? ( debug )"

#PATCHES=(
#	"${FILESDIR}/${PN}-4.16-musl-GLOB_TILDE.patch"
#)

# https://github.com/i3/i3/issues/3013
RESTRICT="test"

S="${WORKDIR}/i3-shape"

src_prepare() {
	default

	eautoreconf
}

my_src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)
	econf "${myeconfargs[@]}"
}

my_src_test() {
	emake check
}

pkg_postinst() {
	# Only show the elog information on a new install
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "There are several packages that you may find useful with ${PN} and"
		elog "their usage is suggested by the upstream maintainers, namely:"
		elog "  x11-misc/dmenu"
		elog "  x11-misc/i3status"
		elog "  x11-misc/i3lock"
		elog "Please refer to their description for additional info."
	fi
}
